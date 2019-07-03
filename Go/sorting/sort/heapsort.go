package sort

// retrieves the left node of the heap node at index `i`
func left(i int) int {
   return 2 * i
}

// retrieves the right node of the heap node at index `i`
func right(i int) int {
   return left(i) + 1
}

// heap sort algorithm
func HeapSort(slc []int) {
   
}
