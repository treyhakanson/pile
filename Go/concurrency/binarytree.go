/*
 NOTE: keep in mind that this could be done without hardcoding the for-loop if
 another function is used and a channel is close. See this
 [link](https://github.com/yaru22/problem-solving/blob/master/go-tour/exercise-equivalent-binary-trees.gos)
 */
package main

import (
   "fmt"
   "golang.org/x/tour/tree"
)

// Walk walks the tree t sending all values
// from the tree to the channel ch.
func Walk(t *tree.Tree, ch chan int) {
	if t != nil {
      Walk(t.Left, ch)
      ch <- t.Value
      Walk(t.Right, ch)
	}
}

// Same determines whether the trees
// t1 and t2 contain the same values.
func Same(t1, t2 *tree.Tree) bool {
   ch1 := make(chan int)
   ch2 := make(chan int)

   go Walk(t1, ch1)
   go Walk(t2, ch2)

   for i := 0; i < 10; i++ {
      x, y := <-ch1, <-ch2
      if x != y {
         return false
      }
   }

   return true
}

func main() {
   t1 := tree.New(1)
   t2 := tree.New(1)

   fmt.Println(Same(t1, t2))
}
