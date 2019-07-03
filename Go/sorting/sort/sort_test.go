package sort

import (
   "fmt"
   "testing"
   "math/rand"
   refsort "sort"
)

// build a test and reference slice with the given number of random elements
func buildSlices(sz int) ([]int, []int) {
   testslice := make([]int, sz)
   refslice := make([]int, sz)

   for i := 0; i < sz; i++ {
      x := rand.Intn(sz)
      testslice[i] = x
      refslice[i] = x
   }

   return testslice, refslice
}

// compare 2 slices, fail test if elements are not the same
func compareSlices(t *testing.T, refslice []int, testslice []int) {
   for i, v := range refslice {
      if testslice[i] != v {
         str := fmt.Sprintf("Expected: %v, but got:", refslice)
         t.Error(str, testslice)
      }
   }
}

func TestSelectionSort(t *testing.T) {
   sz := 25
   testslice, refslice := buildSlices(sz)

   SelectionSort(testslice)
   refsort.Ints(refslice)

   compareSlices(t, refslice, testslice)
}

func TestBubbleSort(t *testing.T) {
   sz := 25
   testslice, refslice := buildSlices(sz)

   BubbleSort(testslice)
   refsort.Ints(refslice)

   compareSlices(t, refslice, testslice)
}

func TestInsertionSort(t *testing.T) {
   sz := 25
   testslice, refslice := buildSlices(sz)

   InsertionSort(testslice)
   refsort.Ints(refslice)

   compareSlices(t, refslice, testslice)
}

func TestMergeSort(t *testing.T) {
   sz := 25
   testslice, refslice := buildSlices(sz)

   testslice = MergeSort(testslice)
   refsort.Ints(refslice)

   compareSlices(t, refslice, testslice)
}

func TestQuickSort(t *testing.T) {
   sz := 25
   testslice, refslice := buildSlices(sz)

   QuickSort(testslice)
   refsort.Ints(refslice)

   compareSlices(t, refslice, testslice)
}
