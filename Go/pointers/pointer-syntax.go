package main

import "fmt"

// `v` is a pointer to an integer
func byRef(v *int) {
  *v = 0 // dereference the pointer, and change its value
}

func main() {
  v := 5
  fmt.Println("Initial value:", v) // 5
  byRef(&v) // `&v` gets the memory location (reference) of `v`
  fmt.Println("Final value:", v) // 0
}
