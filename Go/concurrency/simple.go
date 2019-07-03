package main

import (
	"fmt"
)

func f(n int) {
	for i := 0; i < 10; i++ {
		fmt.Println(n, ":", i)
	}
}

func main() {
	// goroutines are very lightweight; thousands can be running at once
	for i := 0; i < 10; i++ {
		go f(i)
	}

	// included to allow the previous goroutine to finish before the program ends
	var input string
	fmt.Scanln(&input)
}
