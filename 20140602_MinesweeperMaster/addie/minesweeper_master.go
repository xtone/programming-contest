package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"runtime"
)

const (
	click = 'c'
	mine  = '*'
	empty = '.'
)

type cell struct {
	x int
	y int
}

type board struct {
	width  int
	height int
	mine   int
	cells map[cell]rune
	mineCountCells map[cell]int
}

type caseResult struct {
	caseNumber  int
	resultBoard board
}

func (self *board) printBoard() {
	if self.cells == nil {
		fmt.Println("Impossible")
		return
	}

	for y := 0; y < self.height; y++ {
		for x := 0; x < self.width; x++ {
			c, _ := self.cells[cell{x, y}]
			fmt.Printf("%c", c)
		}
		fmt.Println("")
	}
}

func (self *board) init() {
	self.cells = make(map[cell]rune)
	self.mineCountCells = make(map[cell]int)
	for x := 0; x < self.width; x++ {
		for y := 0; y < self.height; y++ {
			self.mineCountCells[cell{x, y}] = 0
		}
	}
}

func (self *board) isValid() bool {
	self.cells[cell{0, 0}] = click
	mines := 0
	for c, mineCount := range (self.mineCountCells) {
		if mineCount > 0 && self.cells[c] == empty {

			isValid := false
			for x := -1; x <= 1 && !isValid; x++ {
				for y := -1; y <= 1 && !isValid; y++ {
					if x == 0 && y == 0 {
						continue
					}

					what, ok := self.cells[cell{c.x + x, c.y + y}]
					if ok && what == mine {
						continue
					}

					count, ok := self.mineCountCells[cell{c.x + x, c.y + y}]
					if ok && count == 0 {
						isValid = true
					}
				}
			}
			if !isValid {
				return false
			}
		}
	}
	return true
}

func (self *board) setMine(mine cell) {
	for x := -1; x <= 1; x++ {
		for y := -1; y <= 1; y++ {
			if x == 0 && y == 0 {
				continue
			}
			nx := mine.x + x
			if nx < 0 || self.width <= nx {
				continue
			}
			ny := mine.y + y
			if ny < 0 || self.height <= ny {
				continue
			}
			self.mineCountCells[cell{nx, ny}]++
		}
	}
}

func (self *board) clone() board {
	newCells := make(map[cell]rune)
	newMineCountCells := make(map[cell]int)
	for key, value := range (self.cells) {
		newCells[key] = value
	}
	for key, value := range (self.mineCountCells) {
		newMineCountCells[key] = value
	}
	return board{self.width, self.height, self.mine, newCells, newMineCountCells}
}

func subSolver(board board, rest, col, y int) board {
	if rest == 0 {
		for i := y; i < board.height; i++ {
			for j := 0; j < board.width; j++ {
				board.cells[cell{j, i}] = mine
				board.setMine(cell{j, i})
			}
		}
		y = board.height
	}

	if !board.isValid() {
		board.cells = nil
		return board
	} else if board.height == y && rest == 0 {
		return board
	}

	restHeight := board.height - y

	if col > rest {
		col = rest
	}

	for c := col; rest <= restHeight*c && rest >= c; c-- {
		b := board.clone()
		for i := 0; i < c; i++ {
			b.cells[cell{i, y}] = empty
		}
		for i := c; i < b.width; i++ {
			b.cells[cell{i, y}] = mine
			b.setMine(cell{i, y})
		}

		newY := y + 1
		newRest := rest - c

		rb := subSolver(b, newRest, c, newY)
		if rb.cells != nil {
			return rb
		}
	}
	board.cells = nil
	return board
}

func solver(board board, caseNum int, ch chan caseResult) {
	rest := board.width * board.height - board.mine
	board.init()
	b := subSolver(board, rest, board.width, 0)
	ch <- caseResult{caseNum, b}
}

func main() {
	// Let's maximize concurrency POWERRRRRRRRR!
	runtime.GOMAXPROCS(runtime.NumCPU())
	inFile, err := os.Open(os.Args[1])
	if err != nil {
		fmt.Println("Open error")
		return
	}

	scanner := bufio.NewScanner(inFile)
	scanner.Scan()
	t, err := strconv.Atoi(scanner.Text())
	if err != nil {
		fmt.Println("Read t error")
		return
	}

	ch := make(chan caseResult)
	for i := 1; i <= t; i++ {
		scanner.Scan()
		rcm := strings.Split(scanner.Text(), " ")

		r, _ := strconv.Atoi(rcm[0])
		c, _ := strconv.Atoi(rcm[1])
		m, _ := strconv.Atoi(rcm[2])
		go solver(board{c, r, m, make(map[cell]rune), make(map[cell]int)}, i, ch)
	}
	results := make(map[int]board)
	for i := 1; i <= t; i++ {
		result := <-ch
		results[result.caseNumber] = result.resultBoard
	}

	for i := 1; i <= t; i++ {
		fmt.Printf("Case #%d:\n", i)
		b, _ := results[i]
		b.printBoard()
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}
