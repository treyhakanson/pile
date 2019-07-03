//: Playground - noun: a place where people can play

import UIKit

class Node {
    
    var id: String
    var children: [Node] = []
    
    init(_ id: String) {
        self.id = id
    }
    
    func recurse() {
        
    }
    
}

let superNode = Node("1")
let node1_1 = Node("1-1")
let node1_2 = Node("1-2")
let node1_3 = Node("1-3")
let node2_1_1 = Node("1-1-1")
let node2_1_2 = Node("1-1-2")

node1_1.children = [node2_1_1, node2_1_2]
superNode.children = [node1_1, node1_2, node1_3]
