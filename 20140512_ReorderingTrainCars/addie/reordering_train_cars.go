package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"sort"
)

type SortByLengthStrings []string

func (sortByLengthStrings SortByLengthStrings) Len() int {
	return len(sortByLengthStrings)
}

func (sortByLengthStrings SortByLengthStrings) Swap(i, j int) {
	sortByLengthStrings[i], sortByLengthStrings[j] = sortByLengthStrings[j], sortByLengthStrings[i]
}

func (sortByLengthStrings SortByLengthStrings) Less(i, j int) bool {
	return len(sortByLengthStrings[i]) < len(sortByLengthStrings[j])
}

type SortRune []rune

func (sortRune SortRune) Len() int {
	return len(sortRune)
}

func (sortRune SortRune) Swap(i, j int) {
	sortRune[i], sortRune[j] = sortRune[j], sortRune[i]
}

func (sortRune SortRune) Less(i, j int) bool {
	return sortRune[i] < sortRune[j]
}

func squeeze(str string) (squeezedStr string) {
	runes := []rune(str)
	newRunes := make([]rune, 0)
	var prevRune rune = 0
	for _, r := range runes {
		if r == prevRune {
			continue
		}
		newRunes = append(newRunes, r)
		prevRune = r
	}

	return string(newRunes)
}

func connectCars(cars []string) (connectd_cars []string, sameCount map[string]int){
	sort.Sort(SortByLengthStrings(cars))
	sameCount = make(map[string]int)
	var index = 0

Outer:
	for index < len(cars) {
		car := cars[index]
		if len(car) == 1 {
			for i, other_car := range cars {
				if i == index {
					continue
				}
				if other_car[0] == car[0] || other_car[len(other_car)-1] == car[0] {
					if len(other_car) == 1 {
						_, ok := sameCount[car]
						if ok {
							sameCount[car]++
						} else {
							sameCount[car] = 2
						}
					}
					cars = append(cars[:index], cars[index+1:]...)
					continue Outer
				}
			}
		} else {
			head := car[0]
			tail := car[len(car) - 1]
			for i, other_car := range cars {
				if i == index {
					continue
				}
				if other_car[len(other_car) - 1] == head {
					if len(other_car) == 1 {
						_, ok := sameCount[other_car]
						if ok {
							sameCount[other_car]++
						} else {
							sameCount[other_car] = 2
						}
					}
					cars[i] = other_car + car[1:]
					cars = append(cars[:index], cars[index+1:]...)
					continue Outer
				}
				 if other_car[0] == tail {
					 if len(other_car) == 1 {
						 _, ok := sameCount[other_car]
						 if ok {
							 sameCount[other_car]++
						 } else {
							 sameCount[other_car] = 2
						 }
					 }
					 cars[i] = car[:len(car)-1] + other_car
					 cars = append(cars[:index], cars[index+1:]...)
					 continue Outer
				 }
			}
		}
		index++
	}

	return cars, sameCount
}

func isValidCars(cars []string) (isValid bool) {
	strCars := ""
	for _, car := range cars {
		strCars += car
	}

	// This is ridiculous! Are there any way to create list of unique items?
	runeCars := []rune(strCars)
	sort.Sort(SortRune(runeCars))
	var prevRune rune = 0
	for _, rune := range(runeCars) {
		if prevRune == rune {
			return false
		}
		prevRune = rune
	}
	return true
}

func solver(cars []string, n, case_number int, ch chan [2]int) {
	modulo := 1000000007
	for i, car := range cars {
		cars[i] = squeeze(car)
	}
	cars, sameCount := connectCars(cars)
	result := 1
	if isValidCars(cars) {
		for _, count := range(sameCount) {
			for i := 1; i <= count; i++ {
				result *= i;
				result %= modulo
			}
		}
		for i := 1; i <= len(cars); i++ {
			result *= i;
			result %= modulo
		}
	} else {
		result = 0
	}
	ch <- [2]int{case_number, result}
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

	ch := make(chan [2]int, 100)
	for i := 1; i <= t; i++ {
		scanner.Scan()
		n, err := strconv.Atoi(scanner.Text())
		if err != nil {
			fmt.Println("Read n error")
			return
		}

		scanner.Scan()
		cars := strings.Split(scanner.Text(), " ")

		go solver(cars, n, i, ch)
	}
	var results [100]int
	for i := 1; i <= t; i++ {
		result := <-ch
		results[result[0] - 1] = result[1]
	}

	for i, result := range results {
		fmt.Printf("Case #%d: %d\n", (i + 1), result)
	}

	if err := scanner.Err(); err != nil {
		fmt.Fprintln(os.Stderr, "reading standard input:", err)
	}
}
