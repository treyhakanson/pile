package main

import (
   "fmt"
)

type Heap struct {
   Data []int
}

func (h *Heap) Left(i int) int {
   return 2 * i + 1
}

func (h *Heap) Right(i int) int {
   return h.Left(i) + 1
}

func (h Heap) Parent(i int) int {
   return int((i - 1) / 2)
}

func (h *Heap) SiftDown(i int) {
   var smallest int

   sz := len(h.Data)
   l  := h.Left(i)
   r  := h.Right(i)

   // if there's no left, there can't be a right, so this node has nowhere to
   // swap with
   if l >= sz {
      return
   }

   if h.Data[l] < h.Data[i] {
      smallest = l
   } else {
      smallest = i
   }

   if r < sz && h.Data[r] < h.Data[smallest] {
      smallest = r
   }

   if smallest == i {
      return
   }

   tmp := h.Data[i]
   h.Data[i] = h.Data[smallest]
   h.Data[smallest] = tmp

   h.SiftDown(smallest)
}

func (h *Heap) SiftUp(i int) {
   // node cannot move higher up if its the root
   if (i == 0) {
      return
   }

   parent := h.Parent(i)

   if (h.Data[parent] > h.Data[i]) {
      tmp := h.Data[parent]
      h.Data[parent] = h.Data[i]
      h.Data[i] = tmp
      h.SiftUp(parent)
   }
}

func (h *Heap) Insert(x int) {
   sz := len(h.Data)
   h.Data = append(h.Data, x)

   h.SiftUp(sz)
}

func (h *Heap) RemoveMin() int {
   min := h.Data[0]
   h.Data[0] = h.Data[len(h.Data) - 1]
   h.Data = h.Data[:len(h.Data) - 1]

   h.SiftDown(0)

   return min
}

func (h *Heap) Heapify() {
   sz := len(h.Data)

   for i := 0; i < sz; i++ {
      h.SiftUp(sz - i - 1)
   }
}

func NewHeap() Heap {
   return Heap{[]int{}}
}

func Heapify(a []int) Heap {
   h := Heap{a}
   h.Heapify()
   return h
}

func main() {
   h := NewHeap()

   h.Insert(4)
   h.Insert(5)
   h.Insert(3)
   h.Insert(1)
   h.Insert(2)

   for len(h.Data) != 0 {
      min := h.RemoveMin()
      fmt.Printf("%d ", min)
   }

   fmt.Println("")

   h = Heapify([]int{4, 5, 3, 1, 2})

   for len(h.Data) != 0 {
      min := h.RemoveMin()
      fmt.Printf("%d ", min)
   }

   fmt.Println("")
}
