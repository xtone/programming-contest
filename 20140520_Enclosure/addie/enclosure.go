package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"math"
	"runtime"
)

type caseResult struct {
	caseNumber int
	stones     int
}

type board struct {
	width   int
	height  int
	require int
	stones  stones
}

type stone struct {
	x int
	y int
}

type stones map[stone]bool

type uniqueStones map[stone]struct{}

func (self *board) isStoneOn(stone stone) bool {
	_, ok := self.stones[stone]
	return ok
}

func (self *board) removeEnclosedStones() {
	for s, ok := range self.stones {
		if ok {
			if self.isStoneOn(stone{s.x - 1, s.y}) &&
					self.isStoneOn(stone{s.x + 1, s.y}) &&
					self.isStoneOn(stone{s.x, s.y - 1}) &&
					self.isStoneOn(stone{s.x, s.y + 1}) {

				self.stones[s] = false
			}
		}
	}
}

func (self *board) countStone() int {
	count := 0
	for _, ok := range self.stones {
		if ok {
			count++
		}
	}

	return count
}

func (self *board) print() {
	for y := 0; y < self.height; y++ {
		for x := 0; x < self.width; x++ {
			notEnclosed, ok := self.stones[stone{x, y}]
			if ok {
				if notEnclosed {
					fmt.Print("o")
				} else {
					fmt.Print("x")
				}
			} else {
				fmt.Print("+")
			}
		}
		fmt.Println("")
	}
}

func createCandidates(board board) uniqueStones {
	candidates := make(uniqueStones)
	for s, ok := range board.stones {
		if !ok {
			continue
		}

		if 0 < s.x {
			candidate := stone{s.x - 1, s.y}
			if !board.isStoneOn(candidate) {
				candidates[candidate] = struct{}{}
			}
		}

		if s.x < board.width-1 {
			candidate := stone{s.x + 1, s.y}
			if !board.isStoneOn(candidate) {
				candidates[candidate] = struct{}{}
			}
		}

		if 0 < s.y {
			candidate := stone{s.x, s.y - 1}
			if !board.isStoneOn(candidate) {
				candidates[candidate] = struct{}{}
			}
		}

		if s.y < board.height-1 {
			candidate := stone{s.x, s.y + 1}
			if !board.isStoneOn(candidate) {
				candidates[candidate] = struct{}{}
			}
		}
	}

	return candidates
}

func countWeightedNeighborPoint(board board, targetStone stone) float64 {
	var point float64 = 0
	left := stone{targetStone.x - 1, targetStone.y}
	if 0 < left.x && left.x < board.width-1 && 0 < left.y && left.y < board.height-1 {
		var neighbor float64 = 0
		if board.isStoneOn(stone{left.x - 1, left.y}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{left.x, left.y - 1}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{left.x, left.y + 1}) {
			neighbor += 1
		}
		point += math.Pow(neighbor, 10)
	}

	right := stone{targetStone.x + 1, targetStone.y}
	if 0 < right.x && right.x < board.width-1 && 0 < right.y && right.y < board.height-1 {
		var neighbor float64 = 0
		if board.isStoneOn(stone{right.x + 1, right.y}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{right.x, right.y - 1}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{right.x, right.y + 1}) {
			neighbor += 1
		}
		point += math.Pow(neighbor, 10)
	}

	top := stone{targetStone.x, targetStone.y - 1}
	if 0 < top.x && top.x < board.width-1 && 0 < top.y && top.y < board.height-1 {
		var neighbor float64 = 0
		if board.isStoneOn(stone{top.x, top.y - 1}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{top.x - 1, top.y}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{top.x + 1, top.y}) {
			neighbor += 1
		}
		point += math.Pow(neighbor, 10)
	}

	bottom := stone{targetStone.x, targetStone.y + 1}
	if 0 < bottom.x && bottom.x < board.width-1 && 0 < bottom.y && bottom.y < board.height-1 {
		var neighbor float64 = 0
		if board.isStoneOn(stone{bottom.x, bottom.y + 1}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{bottom.x - 1, bottom.y}) {
			neighbor += 1
		}
		if board.isStoneOn(stone{bottom.x + 1, bottom.y}) {
			neighbor += 1
		}
		point += math.Pow(neighbor, 10)
	}

	return point
}

func score(board board, targetStone stone) (float64, int) {
	xDiff := targetStone.x - board.width / 2
	yDiff := targetStone.y - board.height / 2
	return countWeightedNeighborPoint(board, targetStone), ((xDiff*xDiff)+(yDiff*yDiff))
}

func determineBestStone(board board, candidates uniqueStones) stone {
	var bestStone stone
	var bestScore float64 = 0
	bestSubScore := int((^uint(0)) >> 1)
	for stone, _ := range candidates {
		score, subScore := score(board, stone)
		if (score > bestScore) || ((score == bestScore) && (subScore < bestSubScore)) {
			bestStone = stone
			bestScore = score
			bestSubScore = subScore
			continue
		}
	}
	return bestStone
}

func solver(board board, i int, ch chan caseResult) {
	board.stones[stone{board.width/2, board.height/2}] = true
	for k := 1; k < board.require; k++ {
		board.stones[determineBestStone(board, createCandidates(board))] = true
		board.removeEnclosedStones()
	}
	ch <- caseResult{i, board.countStone()}
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

	ch := make(chan caseResult, 100)
	for i := 1; i <= t; i++ {
		scanner.Scan()
		nmk := strings.Split(scanner.Text(), " ")

		n, _ := strconv.Atoi(nmk[0])
		m, _ := strconv.Atoi(nmk[1])
		k, _ := strconv.Atoi(nmk[2])
		go solver(board{n, m, k, make(stones)}, i, ch)
	}
	var results [100]int
	for i := 1; i <= t; i++ {
		result := <-ch
		results[result.caseNumber-1] = result.stones
	}

	for i, result := range results {
		fmt.Printf("Case #%d: %d\n", (i+1), result)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}
