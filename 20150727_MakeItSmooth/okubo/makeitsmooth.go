package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"strconv"
	"strings"
)

var scanner *bufio.Scanner

// MaxUint.
const MaxUint = ^uint(0)

// MaxInt.
const MaxInt = int(MaxUint >> 1)

// MakeItSmooth is struct that represented this question.
type MakeItSmooth struct {
	d      int
	i      int
	m      int
	n      int
	pixels []int
	cost   int
}

// IsSmooth is judge pixels about smooth or not.
func (mis *MakeItSmooth) IsSmooth(pixels []int) bool {
	ret := true
	for i := 0; i < len(pixels)-1; i++ {
		pixel := pixels[i]
		nextPixel := pixels[i+1]
		diff := int(math.Abs(float64(nextPixel - pixel)))
		if diff > mis.m {
			ret = false
			break
		}
	}
	return ret
}

// CalcMinCostTwoValues is calc min cost.
func (mis *MakeItSmooth) CalcMinCostTwoValues(n1 int, n2 int) int {
	if mis.IsSmooth([]int{n1, n2}) {
		return 0
	}

	costs := map[string]int{}
	costs["delete"] = mis.d

	if mis.m > 0 {
		n1n2 := int(math.Trunc((math.Abs(float64(n2-n1)) - 1) / float64(mis.m)))
		costs["insert"] = n1n2 * mis.i
	}

	var newN1 int
	if n2 > n1 {
		newN1 = n2 - mis.m
	} else {
		newN1 = n2 + mis.m
	}
	if mis.IsSmooth([]int{newN1, n2}) {
		costs["change_n1"] = int(math.Abs(float64(n1 - newN1)))
	}

	//fmt.Println(costs)

	minCost := MaxInt
	for _, value := range costs {
		if value < minCost {
			minCost = value
		}
	}

	return minCost
}

// CalcMinCostThreeValues is calc min cost.
func (mis *MakeItSmooth) CalcMinCostThreeValues(n1 int, n2 int, n3 int) int {
	if mis.IsSmooth([]int{n1, n2, n3}) {
		return 0
	}

	costs := map[string]int{}

	if mis.IsSmooth([]int{n2, n3}) {
		costs["delete_n1"] = mis.d
	}
	if mis.IsSmooth([]int{n1, n3}) {
		costs["delete_n2"] = mis.d
	}
	if mis.IsSmooth([]int{n1, n2}) {
		costs["delete_n3"] = mis.d
	}

	if mis.IsSmooth([]int{n3}) {
		costs["delete_n1_n2"] = mis.d * 2
	}

	if mis.m > 0 {
		n1n2 := int(math.Trunc((math.Abs(float64(n2-n1)) - 1) / float64(mis.m)))
		n2n3 := int(math.Trunc((math.Abs(float64(n3-n2)) - 1) / float64(mis.m)))
		costs["insert"] = (n1n2 + n2n3) * mis.i
	}

	var newN1 int
	if n2 > n1 {
		newN1 = n2 - mis.m
	} else {
		newN1 = n2 + mis.m
	}
	if mis.IsSmooth([]int{newN1, n2, n3}) {
		costs["change_n1"] = int(math.Abs(float64(n1 - newN1)))
	}

	var newN3 int
	if n3 > n2 {
		newN3 = n2 + mis.m
	} else {
		newN3 = n2 - mis.m
	}
	if mis.IsSmooth([]int{n1, n2, newN3}) {
		costs["change_n3"] = int(math.Abs(float64(n3 - newN3)))
	}

	newN2 := int(math.Floor(float64((n1 + n3) / 2)))
	if mis.IsSmooth([]int{n1, newN2, n3}) {
		costs["change_n2"] = int(math.Abs(float64(n2 - newN2)))
	}

	if mis.IsSmooth([]int{newN1, n2, newN3}) {
		costs["change_n1_n3"] = int(math.Abs(float64(n1-newN1))) + int(math.Abs(float64(n3-newN3)))
	}

	var newN1_2 int
	if n3 > n1 {
		newN1_2 = n3 + mis.m
	} else {
		newN1_2 = n3 - mis.m
	}
	var newN2_2 int
	if n3 > n2 {
		newN2_2 = n3 + mis.m
	} else {
		newN2_2 = n3 - mis.m
	}
	if mis.IsSmooth([]int{newN1_2, newN2_2, n3}) {
		costs["change_n1_n2"] = int(math.Abs(float64(n1-newN1_2))) + int(math.Abs(float64(n2-newN2_2)))
	}

	var newN2_3 int
	if n2 > n1 {
		newN2_3 = n1 + mis.m
	} else {
		newN2_3 = n1 - mis.m
	}
	var newN3_3 int
	if n3 > n1 {
		newN3_3 = n1 + mis.m
	} else {
		newN3_3 = n1 - mis.m
	}
	if mis.IsSmooth([]int{n1, newN2_3, newN3_3}) {
		costs["change_n2_n3"] = int(math.Abs(float64(n2-newN2_3))) + int(math.Abs(float64(n3-newN3_3)))
	}

	//fmt.Println(costs)

	minCost := MaxInt
	for _, value := range costs {
		if value < minCost {
			minCost = value
		}
	}

	return minCost
}

// Solve is calc cost this question.
func (mis *MakeItSmooth) Solve() int {
	pixels := mis.pixels

	mis.cost = 0

	pixelCount := len(pixels)
	if pixelCount < 2 {
		return mis.cost
	}

	if pixelCount == 2 {
		n1 := pixels[0]
		n2 := pixels[1]
		mis.cost += mis.CalcMinCostTwoValues(n1, n2)
		return mis.cost
	}

	// TODO largeの場合、単純に3個ずつみるのは駄目だと思われるので、なんとかする必要がある.
	for i := 0; i < pixelCount-2; i++ {
		n1 := pixels[i]
		n2 := pixels[i+1]
		n3 := pixels[i+2]
		mis.cost += mis.CalcMinCostThreeValues(n1, n2, n3)
	}

	return mis.cost
}

// NewMakeItSmooth is create MakeItSmooth.
func NewMakeItSmooth(d int, i int, m int, n int, pixels []int) *MakeItSmooth {
	//fmt.Println(d, i, m, n, pixels)
	mis := new(MakeItSmooth)
	mis.d = d
	mis.i = i
	mis.m = m
	mis.n = n
	mis.pixels = pixels
	mis.cost = 0
	return mis
}

func nextLine() string {
	scanner.Scan()
	return scanner.Text()
}

func main() {
	var fp *os.File
	var err error

	if len(os.Args) < 2 {
		fp = os.Stdin
	} else {
		fp, err = os.Open(os.Args[1])
		if err != nil {
			panic(err)
		}
		defer fp.Close()
	}

	scanner = bufio.NewScanner(fp)

	count := 0
	if scanner.Scan() {
		count, _ = strconv.Atoi(scanner.Text())
	}

	for i := 0; i < count; i++ {
		caseNo := i + 1

		dimn := strings.Split(nextLine(), " ")
		d, _ := strconv.Atoi(dimn[0])
		i, _ := strconv.Atoi(dimn[1])
		m, _ := strconv.Atoi(dimn[2])
		n, _ := strconv.Atoi(dimn[3])

		_pixels := strings.Split(nextLine(), " ")
		var pixels []int
		for _, _pixel := range _pixels {
			pixel, _ := strconv.Atoi(_pixel)
			pixels = append(pixels, pixel)
		}

		mis := NewMakeItSmooth(d, i, m, n, pixels)
		ret := mis.Solve()

		fmt.Printf("Case #%d: %d\n", caseNo, ret)
		//fmt.Println("---")
	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}
}
