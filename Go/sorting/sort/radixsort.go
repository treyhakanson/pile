package sort

import "math"

// radix sort algorithm (base 10)
func RadixSort(slc []int) {
   var baseArr [10][]int

   max := -int(^uint(0) >> 1) - 1
   for _, v := range slc {
      if (v > max) {
         max = v
      }
   }

   passes := 0
   for max > 0 {
      max /= 10
      passes++
   }

   for pass := 1; pass <= passes; pass++ {
      a := int(math.Pow10(pass))
      for _, v := range slc {
         b := v % a
         baseArr[b] = append(baseArr[b], v)
      }
   }
}

func main() {
   slc := []int{}
   RadixSort(slc)
}
