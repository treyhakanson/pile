package main

import (
   "fmt"
)

type Node struct {
   Data int
   Next *Node
}

type LinkedList struct {
   prefront *Node
   Front *Node
}

func (ll LinkedList) add(x int) {
   newNode := Node{x, nil}
   curNode := ll.prefront

   for curNode.Next != nil {
      curNode = curNode.Next
   }

   curNode.Next = &newNode
}

func (ll LinkedList) pop() int {
   prevNode := ll.prefront
   var nextNode *Node = prevNode.Next

   for nextNode.Next != nil {
      prevNode = nextNode
      nextNode = prevNode.Next
   }

   v := nextNode.Data
   prevNode.Next = nil
   return v
}

func (ll LinkedList) length() int {
   length := 0
   curNode := ll.prefront

   for curNode.Next != nil {
      length++
      curNode = curNode.Next
   }

   return length
}

func (ll LinkedList) print() {
   fmt.Print("<")
   curNode := ll.prefront.Next

   for curNode.Next != nil {
      fmt.Printf("%d, ", curNode.Data)
      curNode = curNode.Next
   }
   fmt.Printf("%d>\n", curNode.Data)
}

func (ll LinkedList) reverse() {
   var prev, current, next *Node;

   prev = nil
   current = ll.prefront.Next
   next = nil

   for current != nil {
      next = current.Next
      current.Next = prev
      prev = current
      current = next
   }

   ll.prefront.Next = prev
}

func NewLinkedList() LinkedList {
   return LinkedList{&Node{0, nil}, nil}
}

func main() {
   ll := NewLinkedList()
   ll.add(1)
   ll.add(9)
   ll.add(6)
   ll.add(7)
   ll.add(11)
   ll.add(72)
   ll.add(10)

   fmt.Print("Linked List:\t\t")
   ll.print()
   ll.reverse()
   fmt.Print("Reversed Linked List:\t")
   ll.print()
}
