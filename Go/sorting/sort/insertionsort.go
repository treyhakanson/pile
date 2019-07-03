package sort

// insertion sort algorithm
func InsertionSort(slc []int) {
   for i := 0; i < len(slc); i++ {
      for j := 0; j < i; j++ {
         if slc[j] > slc[i] {
           tmp := slc[j]
           slc[j] = slc[i]
           slc[i] = tmp
         }
      }
   }
}
