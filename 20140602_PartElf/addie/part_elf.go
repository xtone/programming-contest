package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func gcd(a, b int) int {
	if b == 0 {
		return a
	} else {
		return gcd(b, a%b)
	}
}

func solver(p, q, case_number int) {
	g := gcd(p, q)
	q /= g
	p /= g
	for gen := 1; gen < 40; gen++ {
		if q%2 == 1 {
			break
		}
		q /= 2
		if q == 1 {
			for p > 1 {
				p /= 2
				gen--
			}
			fmt.Printf("Case #%d: %d\n", case_number, gen)
			return
		}
	}
	fmt.Printf("Case #%d: impossible\n", case_number)
}

func main() {
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

	for i := 1; i <= t; i++ {
		scanner.Scan()
		pq := strings.Split(scanner.Text(), "/")
		p, err := strconv.Atoi(pq[0])
		if err != nil {
			fmt.Println("Read p error")
			return
		}

		q, err := strconv.Atoi(pq[1])
		if err != nil {
			fmt.Println("Read q error")
			return
		}

		solver(p, q, i)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}
