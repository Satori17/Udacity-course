import UIKit

//MARK: - Graphs

/*
 Graph is a data structure designed to show relationships between objects. (sometimes called Network)
 
        _________________________
       |             6           |
       |                         |
       |     ___B__              |
       |    /      |   D _______ F
       |  1/      2| 3/ \       /
       \  /        | /  4\    5/
        A________ C       \   /
                            E
 Cycle: A,B,C,D,E,F,A
 
 Node - (A,B..)
 Edge - (1,2..)
 
 graphs do not have root node like trees. Nodes are the parts of graphs that store data, and edges are just the connections between them, but edges can actually store data too. Edges often contain data about the strength of a connection.
 
 Directed Graph:
 Graph where the edges have a sense of direction.
 The relationship between two nodes only applies one way and not the other.
 
 Undirected Graph:
 Graph where the edges with no sense of direction.
 (if you have a graph of people and edges are drawn between two people who met before, directed edges must be unnecessary)
 
 infinite loops often happens, to avoid this we use:
 
 DAG (Directed Acyclic Graph) - directed graph with no cycle
 
 
 Connectivity
 connected graphs has no disconnected vertices.
 
 disconnected:
 
 A___B     C___D
            \
             \
              E
 
 */


//MARK: - Graphs Representation

/*
       0----1
          / |
         /  |
        3---2
 
 all of them are 2D lists. (if you have a list of list of lists, that would be 3D list)
 
 Edge List______________________________________
 
 [ [0,1], [1,2], [1,3], [2,3] ]
 
 edges are represented by a list of two elements. Those numbers are normally numbers that correspond to ID numbers for vertices.
 This list is just showing two nodes that have an edge between them.

 Adjacency List________________________________
 
 [ [1], [0,2,3], [1,3], [1,2] ]
 
 in adjacency list, vertices normally have an ID number that corresponds to the index in an array
 
 
 Adjacency Matrix______________________________
 
 [ (0) [0, 1, 0, 0],
   (1) [1, 0, 1, 1],
   (2) [0, 1, 0, 1],
   (3) [0, 1, 1, 0] ]
 
matrix can be called a rectangular array, because lists inside are all the same length.
The indices in the outer array still represent nodes with those IDs, and the list inside still represent which nodes are adjacent.
 
 */



//MARK: - Graphs in Swift

struct Node {
    
    var value: Int?
    var edges: [Edge]
    
    init(value: Int?) {
        self.value = value
        self.edges = []
    }
}

struct Edge {
    
    var value: Int?
    var nodeFrom: Node?
    var nodeTo: Node?
    
    init(value: Int?, nodeFrom: Node?, nodeTo: Node?) {
        self.value = value
        self.nodeFrom = nodeFrom
        self.nodeTo = nodeTo
    }
    //an edge points from one node to another - the node where it starts is the nodeFrom and the node where it ends is the nodeTo. (nodeFrom -> nodeTo)
}


class Graph {
    
    var nodes: [Node]
    var edges: [Edge]
    
    init(nodes: [Node], edges: [Edge]) {
        self.nodes = nodes
        self.edges = edges
    }
    
    // Don't return an array of edge objects!
    // Return an array of arrays where inner arrays look like
    // (Edge Value, From Node Value, To Node Value)
    func getEdgeList() -> [[Int]] {
        var edgeList = [[Int]]()
        
        for edge in edges {
            if let edgeValue = edge.value, let edgeNodeFrom = edge.nodeFrom?.value, let edgeNodeTo = edge.nodeTo?.value {
                let edgeObjects = [edgeValue, edgeNodeFrom, edgeNodeTo]
                edgeList.append(edgeObjects)
            }
        }
        
        return edgeList
    }
    
    
    
    // Don't return any Node or Edge objects!
    // You'll return a 3D array
    // The indices of the outer list represent "from" nodes.
    // Each section in the array will store an array of arrays where the inner-most arrays look like
    // (To Node Value, Edge Value)
    func getAdjacencyList() -> [[[Int]]] {
        let max = getMaxIndex()
        var adjacencyList = [[[Int]]]()
        
        for _ in 0...max {
                adjacencyList.append([])
            }
        
        for object in edges {
            if let nodeFromValue = object.nodeFrom?.value, let nodeToValue = object.nodeTo?.value {
                if !adjacencyList[nodeFromValue].isEmpty {
                    adjacencyList[nodeFromValue].append([nodeToValue, object.value!])
                } else {
                    adjacencyList[nodeFromValue] = [[nodeToValue, object.value!]]
                }
            }
        }
        
        return adjacencyList
    }
    
    
    // Return a matrix, or 2D array.
    // Row numbers represent from nodes.
    // Column numbers represent to nodes.
    // Store the edge values in each spot, and a 0 if no edge exists.
    func getAdjacencyMatrix() -> [[Int]] {
        let max = getMaxIndex()
        var adjacencyMatrix = [[Int]]()
        
        for _ in 0...max {
            adjacencyMatrix.append([0,0,0,0,0])
        }
        
        for object in edges {
            if let nodeFromValue = object.nodeFrom?.value, let nodeToValue = object.nodeTo?.value {
                adjacencyMatrix[nodeFromValue][nodeToValue] = object.value!
            }
        }
        
        return adjacencyMatrix
    }
    
    
    
    // Helper to be used with adjacency list and adjacency matrix
    // max node value determines the size of the array
    func getMaxIndex() -> Int {
        var maxIndex = 0
        
        for node in nodes {
            if node.value! > maxIndex {
                maxIndex = node.value!
            }
        }
        
        return maxIndex
    }
    
    
    // creates a node with a given value and inserts it into the graph
    func insertNodeWithValue(_ value: Int) {
        let newNode = Node(value: value)
        nodes.append(newNode)
    }
    
    
    // inserts an edge between the "to" and "from" nodes with the specified values
    func insertEdgeWithValue(_ newEdgeValue: Int, nodeFromValue: Int, nodeToValue: Int) {
        var fromFound: Node? = nil
        var toFound: Node? = nil
        
        for node in nodes {
            if nodeFromValue == node.value {
                fromFound = node
            }
            if nodeToValue == node.value {
                toFound = node
            }
        }
        
        if fromFound == nil {
            fromFound = Node(value: nodeFromValue)
            nodes.append(fromFound!)
        }
        if toFound == nil {
            toFound = Node(value: nodeToValue)
            nodes.append(toFound!)
        }
        
        let newEdge = Edge(value: newEdgeValue, nodeFrom: fromFound, nodeTo: toFound)
        fromFound?.edges.append(newEdge)
        toFound?.edges.append(newEdge)
        edges.append(newEdge)
    }
}

// Test cases
let node = Node(value: 1)
let graph = Graph(nodes: [node], edges: [])
graph.insertEdgeWithValue(100, nodeFromValue: 1, nodeToValue: 2)
graph.insertEdgeWithValue(101, nodeFromValue: 1, nodeToValue: 3)
graph.insertEdgeWithValue(102, nodeFromValue: 1, nodeToValue: 4)
graph.insertEdgeWithValue(103, nodeFromValue: 3, nodeToValue: 4)


//print(graph.getEdgeList()) // Should be [(100, 1, 2), (101, 1, 3), (102, 1, 4), (103, 3, 4)]
//print(graph.getAdjacencyList()) // Should be [[], [(2, 100), (3, 101), (4, 102)], [], [(4, 103)], []]
//print(graph.getAdjacencyMatrix()) // Should be [[0, 0, 0, 0, 0], [0, 0, 100, 101, 102], [0, 0, 0, 0, 0], [0, 0, 0, 0, 103], [0, 0, 0, 0, 0]]


//depended on direction
/*
        100
      1---->2
     | \
  101|  \ 102
     \/  \/
     3--->4
      103
 
 */


//MARK: - Graph Traversal


/*
                G----H
           P   / \
            \ /   \
             R     A
 

 //difference between stack & queue:
 stack - you can remove the most recent element from stack (last)
 queue - you can remove the first element from the queue


 DFS (depth-first search) on Graph
 time complexity - O(|E| + |V|) (number of edges + number of vertices)
 uses Stack

 order: G,R,A,P,H
 

 BFS (breath-first search) on Graph
 time complexity - O(|E| + |V|) (number of edges + number of vertices)
 uses Queue
 
 order: G,H,A,R,P
 
 //when we run out of edges, we can just dequeue a node from the queue and use that as next starting place.

*/



class NNode {
    
    var value: Int?
    var edges: [EEdge]
    var visited = false
    
    init(value: Int?) {
        self.value = value
        self.edges = []
    }
}

class EEdge {
    
    var value: Int?
    var nodeFrom: NNode?
    var nodeTo: NNode?
    
    init(value: Int?, nodeFrom: NNode?, nodeTo: NNode?) {
        self.value = value
        self.nodeFrom = nodeFrom
        self.nodeTo = nodeTo
    }
}

class GGraph {
    
    var nodes: [NNode]
    var edges: [EEdge]
    
    init(nodes: [NNode], edges: [EEdge]) {
        self.nodes = nodes
        self.edges = edges
    }
    
    // Create a recursive implementation.
    // Return a list of the node values.
    func dfs(_ startNode: NNode) -> [Int] {
        let visitedNodes = [startNode.value!]
        return dfsHelper(startNode, visited: visitedNodes)
    }
    
    // Create an iterative implementation.
    // Return a list of the node values.
    func bfs(_ startNode: NNode) -> [Int] {
        var nodeValues = [Int]()
        
        for edge in startNode.edges {
            if let fromNode = edge.nodeFrom, let toNode = edge.nodeTo {
                if !fromNode.visited {
                    fromNode.visited = true
                    nodeValues.append(fromNode.value!)
                }
                if !toNode.visited {
                    toNode.visited = true
                    nodeValues.append(toNode.value!)
                }
            }
        }
        
        return nodeValues
    }
    
    //better version of bfs
    func bfss(_ startNode: NNode) -> [Int] {

        var visited: [Int] = []
        var toVisit: [NNode] = [] // Treat this array as a queue

        toVisit.append(startNode)
        visited.append(startNode.value!)
        startNode.visited = true

        while !toVisit.isEmpty {
            let node = toVisit.removeFirst()

            for edgeObject in node.edges {
                let neighborNode = edgeObject.nodeTo

                if !(neighborNode?.visited)! {
                    toVisit.append(neighborNode!)
                    neighborNode?.visited = true
                    visited.append((neighborNode?.value)!)
                }
            }
        }
        return visited
    }
    
    
    // helper method - use to implement DFS recursively
    func dfsHelper(_ current: NNode, visited: [Int]) -> [Int] {
        var result = [Int]()
        current.visited = true
        
        for edge in current.edges {
            if let fromNode = edge.nodeFrom, let toNode = edge.nodeTo {
                if !fromNode.visited {
                    fromNode.visited = true
                    result.append(fromNode.value!)
                } else if !toNode.visited {
                    toNode.visited = true
                    result.append(toNode.value!)
                }
            }
        }
        
        return result
    }
    
    //better version of dfs
    func dfsHelperr(_ current: NNode, visited: [Int]) -> [Int] {
        var result = visited

        for edgeObject in current.edges {
            if !result.contains((edgeObject.nodeTo?.value)!) {
                result.append(edgeObject.nodeTo!.value!)
                result = dfsHelperr(edgeObject.nodeTo!, visited: result)
            }
        }
        return result
    }
    
    
    // creates a now with a given value and inserts it into the graph
    func insertNodeWithValue(_ value: Int) {
        let newNode = NNode(value: value)
        nodes.append(newNode)
    }
    
    // inserts an edge between the "to" and "from" nodes with the given value
    func insertEdgeWithValue(_ newEdgeValue: Int, nodeFromValue: Int, nodeToValue: Int) {
        var fromFound: NNode? = nil
        var toFound: NNode? = nil
        
        for node in nodes {
            if nodeFromValue == node.value {
                fromFound = node
            }
            if nodeToValue == node.value {
                toFound = node
            }
        }
        
        if fromFound == nil {
            fromFound = NNode(value: nodeFromValue)
            nodes.append(fromFound!)
        }
        if toFound == nil {
            toFound = NNode(value: nodeToValue)
            nodes.append(toFound!)
        }
        
        let newEdge = EEdge(value: newEdgeValue, nodeFrom: fromFound, nodeTo: toFound)
        fromFound?.edges.append(newEdge)
        toFound?.edges.append(newEdge)
        edges.append(newEdge)
    }
}

//Test cases
let ggraph = GGraph(nodes: [], edges: [])
ggraph.insertEdgeWithValue(100, nodeFromValue: 1, nodeToValue: 2)
ggraph.insertEdgeWithValue(101, nodeFromValue: 1, nodeToValue: 3)
ggraph.insertEdgeWithValue(102, nodeFromValue: 1, nodeToValue: 4)
ggraph.insertEdgeWithValue(103, nodeFromValue: 3, nodeToValue: 4)

print(ggraph.dfs(ggraph.nodes[0])) // Should be [1, 2, 3, 4]
print(ggraph.bfs(ggraph.nodes[0])) // Should be [1, 2, 3, 4]

/*
 
           2-----1----3
                 |   /
                 |  /
                 | /
                 4
 */


//MARK: - Eulerian Path
/*
 Eulerian path is most efficient way of searching in Graphs, O(numberOfEdges).
 
 it visits every edge once.
 
 Not every graph is capable of eulerian path. Graphs can only have Eulerian cycles if all vertices have an even degree or an even number of edges connected to them.
 
           1       1
      A ------- B ---- C
       \    2 /  \2  /
      3 \    /    \ / 3
          E ------- D
 
 ABE
 +
 BCD
 _____
 ABCD
 
 create a path thorugh those unseen edges and continue this process until you've seen every edge in the graph once, then simply add the paths together, combining them at the nodes they have in common.
 
 */



//MARK: - Hamiltonian Path

/*
 Hamiltonian Path also must goes through every vertex once.
 Similarly, Hamiltonian cycle will start and end with the same vertex.
 
 */
