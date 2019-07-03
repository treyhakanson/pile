package sort

// selection sort algorithm
func SelectionSort(slc []int) {
   slcLen := len(slc)
   var minIdx int

   for i := 0; i < slcLen; i++ {
      minIdx = i

      for j := i; j < slcLen; j++ {
         if (slc[j] < slc[minIdx]) {
            minIdx = j
         }
      }

      tmp := slc[i]
      slc[i] = slc[minIdx]
      slc[minIdx] = tmp
   }
}
