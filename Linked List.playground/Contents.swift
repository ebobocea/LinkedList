import UIKit

class Node<T> {
    var value: T
    var next: Node?
    
    init(value: T, next: Node? = nil){
        self.value = value
        self.next = next
    }
}

struct LinkedList<T>{
    var head: Node<T>?
    var tail: Node<T>?
    
    private var isEmpty: Bool{
        return head == nil
    }
    
    mutating func push(_ value: T){
        head = Node(value: value, next: head)
        if tail == nil{
            tail = head
        }
    }
    
    mutating func append(_ value: T){
        guard !isEmpty else {
            push(value)
            return
        }
        
        let node = Node(value: value)
        tail!.next = node
        tail = node
    }
    
    func node(at index:Int) -> Node<T>? {
        if index < 0 { return nil }
        var currentIndex =  0
        var currentNode = head
        
        while(currentNode != nil && currentIndex < index){
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    mutating func insert(_ value: T, at index: Int) {
        if index == 0 {
            push(value)
            return
        }
        let prev = node(at: index-1)
        let newNode = Node(value: value, next: prev?.next)
        prev?.next = newNode
        if prev?.next == nil {
            tail = newNode
        }
    }


    
    mutating func remove(at index: Int) -> T? {
        if isEmpty {
            return nil
        }
        
        if index == 0 {
            return pop()
        }
        
        let prev = node(at: index-1)
        let current = prev?.next
        prev?.next = current?.next
        return current?.value
    }
    
    mutating func pop() -> T? {
        defer {
            head = head?.next
            if isEmpty{
                tail = nil
            }
        }
        return head?.value
    }
    
    func count() -> Int {
        var count = 0
        var current = head
        while current != nil {
            count += 1
            current = current?.next
        }
        return count
    }
    mutating func removeLast() -> T? {
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }

    mutating func removeAfter(node: Node<T>) -> T? {
        guard let nextNode = node.next else {
            return nil
        }
        if nextNode.next == nil {
            tail = node
        }
        node.next = nextNode.next
        return nextNode.value
    }

    init() {}
}

