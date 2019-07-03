package sort

// bubble sort algorithm
func BubbleSort(slc []int) {
   for i := 1; i < len(slc); i++ {
      if slc[i] < slc[i - 1] {
            tmp := slc[i - 1]
            slc[i - 1] = slc[i]
            slc[i] = tmp
            i = 0
      }
   }
}
