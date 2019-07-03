package main

import (
   "fmt"
   "time"
)

func main() {
   // this limiter will limit to one request per 200ms
   requests := make(chan int, 10)
   for i := 0; i < cap(requests); i++ {
      requests <- i
   }
   close(requests)

   limiter := time.Tick(time.Millisecond * 200)

   for req := range requests {
      <-limiter // will block until tick is finished, blocking request handling
      fmt.Println("Request:", req, time.Now())
   }



   burstyLimiter := make(chan time.Time, 3)

   for i := 0; i < cap(burstyLimiter); i++ {
      burstyLimiter <- time.Now()
   }

   go func() {
         for t := range time.Tick(time.Millisecond * 200) {
            burstyLimiter <- t
         }
   }()

   burstyRequests := make(chan int, 5)
   for i := 0; i < 5; i++ {
      burstyRequests <- i
   }
   close(burstyRequests)

   for req := range burstyRequests {
      <-burstyLimiter
      fmt.Println("Request (Bursty):", req, time.Now())
   }
}
