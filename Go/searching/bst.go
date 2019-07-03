package main

import (
   "fmt"
)

type Node struct {
   Value int
   Left  *Node
   Right *Node
}

func NewNode(value int) *Node {
   return &Node{value, nil, nil}
}

func BFS(node *Node) {
   q := []*Node{node}

   for len(q) != 0 {
      n := q[0]
      q = q[1:]

      fmt.Println(n.Value)

      if n.Left != nil {
         q = append(q, n.Left)
      }

      if n.Right != nil {
         q = append(q, n.Right)
      }
   }
}

func DFS(node *Node, order int) {
   if node == nil {
      return
   }

   switch order {
   case 1: // preorder
      fmt.Println(node.Value)
      DFS(node.Left, order)
      DFS(node.Right, order)
   case 2: // inorder
      DFS(node.Left, order)
      fmt.Println(node.Value)
      DFS(node.Right, order)
   case 3: // postorder
      DFS(node.Left, order)
      DFS(node.Right, order)
      fmt.Println(node.Value)
   }
}

func ZigZag(node *Node) {
   s1 := []*Node{node}
   s2 := []*Node{}

   for len(s1) != 0 || len(s2) != 0 {
      for len(s1) != 0 {
         n := s1[len(s1) - 1]
         s1 = s1[:len(s1) - 1]

         fmt.Println(n.Value)

         if n.Right != nil {
            s2 = append(s2, n.Right)
         }
         if n.Left != nil {
            s2 = append(s2, n.Left)
         }
      }

      for len(s2) != 0 {
         n := s2[len(s2) - 1]
         s2 = s2[:len(s2) - 1]

         fmt.Println(n.Value)

         if n.Left != nil {
            s1 = append(s1, n.Left)
         }
         if n.Right != nil {
            s1 = append(s1, n.Right)
         }
      }
   }
}

func main() {
   root := NewNode(1)

   node1 := NewNode(2)
   node2 := NewNode(3)
   root.Left = node1
   root.Right = node2

   node3 := NewNode(4)
   node4 := NewNode(5)
   node1.Left = node3
   node1.Right = node4

   node5 := NewNode(6)
   node6 := NewNode(7)
   node2.Left = node5
   node2.Right = node6

   node7 := NewNode(8)
   node8 := NewNode(9)
   node3.Left = node7
   node3.Right = node8

   node9 := NewNode(10)
   node10 := NewNode(11)
   node4.Left = node9
   node4.Right = node10

   node11 := NewNode(12)
   node12 := NewNode(13)
   node5.Left = node11
   node5.Right = node12

   node13 := NewNode(14)
   node14 := NewNode(15)
   node6.Left = node13
   node6.Right = node14

   DFS(root, 1)
}
