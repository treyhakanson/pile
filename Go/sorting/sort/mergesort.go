package sort

func merge(pt1 []int, pt2 []int) []int {
   totalLen := len(pt1) + len(pt2)
   slc := []int{}

   for i := 0; i < totalLen; i++ {
      if pt1[0] < pt2[0] {
         slc = append(slc, pt1[0])
         pt1 = pt1[1:]
      } else {
         slc = append(slc, pt2[0])
         pt2 = pt2[1:]
      }
      if len(pt1) == 0 || len(pt2) == 0 {
         break
      }
   }

   slc = append(slc, pt1...)
   return append(slc, pt2...)
}

// merge sort algorithm
func MergeSort(slc []int) []int {
   slcLen := len(slc)

   if slcLen > 1 {
      pt1 := MergeSort(slc[slcLen/2:])
      pt2 := MergeSort(slc[:slcLen/2])
      slc = merge(pt1, pt2)
   }

   return slc
}
