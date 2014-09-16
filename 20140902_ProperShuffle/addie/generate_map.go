package main

import (
	"fmt"
	"math/rand"
)

func main() {
	var result [1000][1000]int
	for i := 0; i < 1000000; i++ {
		array := bad_shuffle()
		for i := 0; i < 1000; i++ {
			result[i][array[i]]++
		}
	}

	for i := 0; i < 1000; i++ {
		for j := 0; j < 1000; j++{
			fmt.Printf("%d ", result[i][j])
		}
		fmt.Println()
	}
}

func bad_shuffle() (array [1000]int) {
	for i := 0; i < 1000; i++ {
		array[i] = i
	}
	for i := 0; i < 1000; i++ {
		s := rand.Intn(1000)
		array[i], array[s] = array[s], array[i]
	}

	return
}

func good_shuffle() (array [1000]int) {
	for i := 0; i < 1000; i++ {
		array[i] = i
	}
	for i := 0; i < 1000; i++ {
		s := rand.Intn(1000 - i) + i
		array[i], array[s] = array[s], array[i]
	}

	return
}
