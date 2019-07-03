package main

import (
   "fmt"
)

func fibonacci(c chan int, quit chan int) {
   x := 0
   y := 1

   for {
      select {
      case c <- x:
         x, y = y, x + y
      case <- quit:
         return // the quit signal has been received
      }
   }
}

func main() {
   c := make(chan int)
   quit := make(chan int, 1)

   go fibonacci(c, quit)
   for i := 0; i < 10; i++ {
      fmt.Println(<- c)
   }

   quit <- 1
}
