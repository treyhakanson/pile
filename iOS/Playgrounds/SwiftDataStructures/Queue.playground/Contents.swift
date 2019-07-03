public class Node<T> {
    public var next: Node<T>?
    public var data: T?
    
    init(data: T) {
        self.data = data
    }
    
    init() {
        self.data = nil
    }
}

public struct Queue<T> {
    private let preFirst: Node<T>
    public var length: Int
    
    init() {
        self.preFirst = Node<T>()
        self.length = 0
    }
    
    mutating func enqueue(data: T) -> Void {
        var last = preFirst
        
        while let next = last.next {
            last = next
        }
        
        let node = Node<T>(data: data)
        last.next = node
        
        self.length += 1
    }
    
    mutating func dequeue() -> T {
        let first = self.preFirst.next!
        self.preFirst.next = first.next
        self.length -= 1
        return first.data!
    }
    
    func peek() -> T {
        return self.preFirst.next!.data!
    }
    
    func toString() -> String {
        var str = "<"
        var last = preFirst
        
        while let next = last.next {
            str += "\(String(describing: next.data)),"
            last = next
        }
        
        return str + ">"
    }
}

var q = Queue<Int>()
print(q.toString())

q.enqueue(data: 1)
q.enqueue(data: 1)
q.enqueue(data: 3)
q.enqueue(data: 1)

print(q.toString())
q.dequeue()
print(q.toString())
