package main

import (
   "fmt"
   "time"
)

func main() {
   done := time.After(time.Second * 10)
   fmt.Print("Loading")

   for {
      select {
      case <- done:
         fmt.Println("\nDone!")
         return
      default:
         fmt.Print(".")
         time.Sleep(time.Second * 1)
      }
   }
}
