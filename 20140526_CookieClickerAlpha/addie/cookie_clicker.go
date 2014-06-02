package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type caseResult struct {
	caseNumber int
	time       float64
}

func solver(c, f, x float64, i int, ch chan caseResult) {
	var rate float64 = 2.0
	var time float64 = 0.0
	var rest float64 = x

	for ; ; {
		time_to_c := c / rate
		time_to_x := rest / rate
		if time_to_c < time_to_x {
			time_to_x_with_boost := time_to_c + (rest / (rate + f))
			if time_to_x_with_boost < time_to_x {
				rate += f
				time += time_to_c
			} else {
				break
			}
		} else {
			break
		}
	}

	time += rest/rate

	ch <- caseResult{caseNumber: i, time: time}
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
		cfx := strings.Split(scanner.Text(), " ")

		c, _ := strconv.ParseFloat(cfx[0], 64)
		f, _ := strconv.ParseFloat(cfx[1], 64)
		x, _ := strconv.ParseFloat(cfx[2], 64)
		go solver(c, f, x, i, ch)
	}
	var results [100]float64
	for i := 1; i <= t; i++ {
		result := <-ch
		results[result.caseNumber - 1] = result.time
	}

	for i, result := range results {
		fmt.Printf("Case #%d: %.7f\n", (i + 1), result)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}
