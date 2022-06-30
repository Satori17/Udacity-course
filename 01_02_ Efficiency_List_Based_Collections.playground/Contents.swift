import UIKit

//MARK: - 1
class Classy {
    
    var items: [String]
    var classiness: Int
    
    init() {
        self.items = []
        self.classiness = 0
    }
    
    //Write your addItem function here
    func addItem(item: String) {
        items.append(item)
        switch item {
        case "tophat":
            classiness += 2
        case "bowtie":
            classiness += 4
        case "monocle":
            classiness += 5
        default:
            classiness += 0
        }
    }
    //Write your getClassiness function here
    func getClassiness() -> Int {
        return classiness
    }
}

//MARK: - 2

// - Linked Lists

//class Node {
//    var value: Int
//    var next: Node?
//
//    init(value: Int) {
//        self.value = value
//    }
//}
//
//
//
//class LinkedList {
//
//    var head: Node?
//
//    init(head: Node?) {
//        self.head = head
//    }
//
//    func append(_ node: Node) {
//        guard head != nil else {
//            head = node
//            return
//        }
//
//        var current = head
//        while let _ = current?.next {
//            current = current?.next
//        }
//        current?.next = node
//    }
//
//    // Get a node from a particular position.
//    // Assume the first position is "1".
//    // Return "nil" if position is not in the list.
//    func getNode(atPosition position: Int) -> Node? {
//        guard position > 0 else {
//            return nil
//        }
//
//        var initialValue = 1
//        var current = head
//
//
//        while initialValue <= position && current != nil {
//            if initialValue == position {
//                return current
//            }
//            initialValue += 1
//            current = current?.next
//        }
//
//        return nil
//    }
//
//    // Insert a new node at the given position.
//    // Assume the first position is "1".
//    // Inserting at position 3 means between
//    // the 2nd and 3rd nodes.
//    func insertNode(_ node: Node, at position: Int) {
//        let newNode = getNode(atPosition: position-1)
//        let previousNode = getNode(atPosition: position)
//        newNode?.next = node
//        node.next = previousNode
//    }
//
//    // Delete the first node with a given value.
//    func deleteNode(withValue value: Int) {
//        guard head != nil else {
//            return
//        }
//        var nodeToDelete = head
//
//        while nodeToDelete?.value != value {
//            nodeToDelete = nodeToDelete?.next
//        }
//        head = nodeToDelete?.next
//        nodeToDelete = nil
//    }
//}
//
//// Test cases
//// Set up some Nodes
//let n1 = Node(value: 1)
//let n2 = Node(value: 2)
//let n3 = Node(value: 3)
//let n4 = Node(value: 4)
//
//// Start setting up a LinkedList
//let ll = LinkedList(head: n1)
//ll.append(n2)
//ll.append(n3)
//// Test getNode(atPosition:)
//print(ll.head!.next!.next!.value) // Should print 3
//print(ll.getNode(atPosition: 3)!.value) // Should also print 3
//
//// Test insert
//ll.insertNode(n4, at: 3)
//print(ll.getNode(atPosition: 3)!.value) // Should print 4 now
//print(ll.getNode(atPosition: 4)!.value)
//
//// Test delete(withValue:)
//ll.deleteNode(withValue: 1)
//print(ll.getNode(atPosition: 1)!.value) // Should print 2 now
//print(ll.getNode(atPosition: 2)!.value) // Should print 4 now
//print(ll.getNode(atPosition: 3)!.value) // Should print 3
//


// - STACK

class Stack {
    
    var ll: LinkedList
    
    init(top: Node?) {
        self.ll = LinkedList(head: top)
    }
    
    // add a node to the top of the stack
    func push(_ node: Node) {
        guard ll.head != nil else { return }
        ll.append(node)
    }
    
    // remove and return the topmost node from the stack
    func pop() -> Node? {
        var firstElement = ll.head
        
        while firstElement?.next != nil {
            firstElement = firstElement?.next
        }
        if let last = firstElement {
            ll.deleteNode(withValue: last.value)
            return last
        }
        
        return nil
    }
}

class Node {
    
    var value: Int
    var next: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class LinkedList {
    
    var head: Node?
    
    init(head: Node?) {
        self.head = head
    }
    
    func append(_ node: Node) {
        
        guard head != nil else {
            head = node
            return
        }
        
        var current = head
        while let _ = current?.next {
            current = current?.next
        }
        current?.next = node
    }
    
    func getNode(atPosition position: Int) -> Node? {
        guard position > 0 else {
            return nil
        }
        
        var counter = 1
        var current = head
        
        while current != nil && counter <= position {
            if counter == position {
                return current
            }
            current = current?.next
            counter += 1
        }
        return nil
    }
    
    func insertNode(_ node: Node, at position: Int) {
        guard position > 0 else {
            return
        }
        
        var counter = 1
        var current = head
        
        if position > 1 {
            while current != nil && counter < position {
                if counter == position - 1 {
                    node.next = current?.next
                    current?.next = node
                }
                current = current?.next
                counter += 1
            }
        } else if position == 1 {
            node.next = head
            head = node
        }
    }
    
    func deleteNode(withValue value: Int) {
        var current = head
        var previous: Node?
        
        while current?.value != value && current?.next != nil {
            previous = current
            current = current?.next
        }
        
        if current?.value == value {
            if previous != nil {
                previous?.next = current?.next
            } else {
                head = current?.next
            }
        }
    }
}

// Test cases
// Set up some nodes
let n1 = Node(value: 1)
let n2 = Node(value: 2)
let n3 = Node(value: 3)
let n4 = Node(value: 4)

// Start setting up a Stack
let stack = Stack(top: n1)

// Test stack functionality

stack.push(n2)
stack.push(n3)

//print(stack.pop()!.value) // Should be 3
//print(stack.pop()!.value) // Should be 2
//print(stack.pop()!.value) // Should be 1
//print(stack.pop()?.value) // Should be nil
stack.push(n4)
//print(stack.pop()!.value) // Should be 4




// - QUEUES

class Queue {
    
    var storage: [Int]
    
    init(head: Int) {
        storage = [head]
    }
    
    // add the element to the queue
    func enqueue(_ element: Int) {
        storage.append(element)
    }
    
    // return the next element to be dequeued from the queue
    // if the queue is empty, return nil
    func peek() -> Int? {
        if !storage.isEmpty {
            return storage[0]
        }
        return nil
    }
    
    // remove and return the next element to be dequeued
    func dequeue() -> Int? {
        let dequeued = storage.removeFirst()
            return dequeued
    }
}

// Test cases

// Setup
let q = Queue(head: 1)
q.enqueue(2)
q.enqueue(3)

// Test peek
print(q.peek()!) // Should be 1

// Test dequeue
print(q.dequeue()!) // Should be 1
 
// Test enqueue
q.enqueue(4)
print(q.dequeue()!) // Should be 2
print(q.dequeue()!) // Should be 3
print(q.dequeue()!) // Should be 4
q.enqueue(5)
print(q.peek()!) // Should be 5
