import UIKit

/*
 
                                                                          D
                                                                        /   \
                                                                       B     E
                                                                     /   \     \
                                                                    A     C     F
 
 Depth-First Search (DFS) Algorithm:
 It starts with the root node and first visits all nodes of one branch as deep as possible of the chosen Node and before backtracking, it visits all other branches in a similar fashion. There are three sub-types under this:
 
 Tree Traversal algorithms - Pre_order, In_order, Post_order.
 
 //we are checking from the root and continuing with it's first child (from left to right)
 1) Pre_order: D,B,A,C,E,F
 
 //we are not checking parent until we see child node, it's following in orter from left to right
 2) In_order: A,B,C,D,E,F
 
 //We won't be able to check off the parent node until we've seen all of its descendants or we visited both of its children and returned.
 3) Post_order: A,C,B,F,E,D
 
 
 Breadth-First Search (BFS) Algorithm: It also starts from the root node and visits all nodes of current depth before moving to the next depth in the tree.
 */


class Node {
    
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class BinaryTree {
    
    var root: Node
    
    init(rootValue: Int) {
        self.root = Node(value: rootValue)
    }
    
    // Return true if the value is in the tree, otherwise return false
    func search(_ value: Int) -> Bool {
        var current = root
        
        while current.value != value {
            if let cur = current.left {
                current = cur
            } else if let curr = current.right {
                current = curr
            } else {
                return false
            }
        }
        
        return true
    }
    
    //   1
    //  2  3
    //4  5
    
    // Return a string containing all tree nodes as they are visited in a pre-order traversal.
    func printTree() -> String {        
       
        return preorderPrint(root)!
    }
    
    // Helper method - use to create a recursive search solution.
    func preorderSearch(_ start: Node?, value: Int) -> Bool {
        if let start = start {
            if start.value == value {
                return true
            } else {
                return preorderSearch(start.left, value: value) || preorderSearch(start.right, value: value)
            }
        }
        return false
    }
    
    // Helper method - use to construct a string representing the preordered nodes
    func preorderPrint(_ start: Node?) -> String? {
        if start == nil {
            return ""
        }
        
        var resultString = "\(start!.value)"
        resultString += preorderPrint(start!.left)!
        resultString += preorderPrint(start!.right)!
        
        return resultString
    }
}

// Test cases
// Set up tree
let tree = BinaryTree(rootValue: 1)
tree.root.left = Node(value: 2)
tree.root.right = Node(value: 3)
tree.root.left?.left = Node(value: 4)
tree.root.left?.right = Node(value: 5)

// Test search
print(tree.search(4)) // Should be true
print(tree.search(6)) // Should be false

// Test printTree
print(tree.printTree()) // Should be 1-2-4-5-3



//MARK: - Binary Search Tree (BST)            time complexity - O(log(n))


class BST {
    
    var root: Node
    
    init(value: Int) {
        self.root = Node(value: value)
    }
    
    func search(_ value: Int) -> Bool {
        return searchHelper(root, value: value)
    }
    
    // create a node with the given value and insert it into the binary tree
    func insert(_ value: Int) {
        insertHelper(root, value: value)
    }
    
    // helper method - use to implement a recursive search function
    func searchHelper(_ current: Node?, value: Int) -> Bool {
        if let current = current {
            if current.value == value {
                return true
            } else {
                return searchHelper(current.left, value: value) || searchHelper(current.right, value: value)
            }
        }
        return false
    }
    
    // helper method - use to implement a recursive insert function
    func insertHelper(_ current: Node, value: Int) {

        if current.value > value {
            if let leftValue = current.left {
                insertHelper(leftValue, value: value)
            } else {
                current.left = Node(value: value)
                print("sopo1")
            }
            
        } else {
            if let rightValue = current.right {
                insertHelper(rightValue, value: value)
            } else {
                current.right = Node(value: value)
                print("sopo2")
            }
        }
    }
}

// Test cases
// Set up tree
let trees = BST(value: 4)

// Insert elements
trees.insert(2)
trees.insert(1)
trees.insert(3)
trees.insert(5)



// Check search
print(trees.search(4)) // Should be true
print(trees.search(6)) // Should be false

print("_______________________________________________________")


//MARK: - Red-black Tree Rules

/*
 1) nodes assigned in additional color property, where the values must be either red or black, its usage is just a convention to distinguish.
 2) every node in tree that does not otherwise have two leaves, must have null children. All null leaf nodes must be colored black.
 3) if a node is Red, both of its children must be black.
 4) (Optional rule) root node must be black.
 5) every path from a node to its descendant null node must contain the same number of black nodes.

*/
