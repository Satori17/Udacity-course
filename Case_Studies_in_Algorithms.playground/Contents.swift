import UIKit


//MARK: - Shortest Path Problem

//solution - BFS (for unweighted path)


//MARK: - Dijkstra's Algorithm

// efficiency - O(|V|2)

//to run really efficiently - O ( |E| + |V| log(|V|))


//MARK: - Knapsack Problem

//knapsack problem really is a optimization problem

//brute force solution - try every combination and check which fits best
//runtime efficiency - O(2n) where n = number of objects


//MARK: - Faster Algorithm
//Max value for min weight


/*
        index 1 |  2  |  3  |  4  |  5  |  6 (max weight)
        value 0 |  0  |  0  |  0  |  0  |  0
 
 These are objects we're trying to fit in a knapsack with weight limit 6:
 weight: 2 |   5 |   4 |
 value:  6 |   9 |   5 |
 
 
 runtime is O(nW)  - "Pseudo Polynomial Time"
 (this algorithm is much faster than exponential time algorithms)
 
 n = number of elements
 W = weight limit
 */


//MARK: - Dynamic Programming

//breaking task into subproblems

/*             6              (weight 4)
 value at weight limit = value of current object + value in table at (weight limit - current object)
              6    -   4
 
 11 = 5 + 6
 
 dynamic programming benefits -
 you compute and save solutions to smaller problems. then you don't need to calculate them again for more complex problems.
 
 
 To fix problem with dynamic programming ask yourself :
 "Can I break this problem up into subproblems?"
 */


//MARK: - Traveling Salesman Problem (TSP)

/*
 graph where all the nodes are cities and all the edges are roads between them.
 
 TSP asks: "what's the fastest way for our salesman to travel between every city and return home?"
 
 TSP is used in everything from micro Chip design to DNA sequence.
 */

//This problem is defined as special class of problems called "NP - Hard"

/*
 NP-Hard problems don't have known algorithms that can solve them in polynomial time
 
 Polynomial time - O(n2), O(n), O(2)
 
 
 because of hardness of that problem, there are two classes of solutions:
 1. Exact Algorithms
 2. Approximation Algorithms
 
 brute force solution also works with same philosophy as knapsack, but it takes longer time
 
 
 there are also dynamic programming solutions for TSP :
 1. Held-Karp Algorithm - O(n2 2n) (runtime is an exponential time)
 
 
 another algorithm for this is " Christofides Algorithm" which turn graph into a tree, where the starting node is the root creating and travesing through it in a particularly intelligent way.
 */


//MARK: - Number of islands problem in swift

/*
 Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.
 */

var islands: [[Character]] = [  ["1","1","1","1","0"],
                                ["1","1","0","1","0"],
                                ["1","1","0","0","0"],
                                ["0","0","0","0","0"]
] // should be 1 the answer

func numIslands(_ grid: [[Character]]) -> Int {

    var result = 0
    var notGrid = grid
    for row in 0..<grid.count {
        for column in 0..<notGrid[row].count {
            if notGrid[row][column] == "1" {
                result += 1
                islandSearchDFS(&notGrid, row, column)
            }
        }
    }
    return result
}

func islandSearchDFS(_ grid: inout [[Character]],_ row: Int, _ column: Int) {
    if row < 0 || row>=grid.count || column < 0 || column>=grid[row].count || grid[row][column] == "0"{
        return
    } // 1

    grid[row][column] = "0" // visited island //2

    islandSearchDFS(&grid, row-1, column)  //3
    islandSearchDFS(&grid, row+1, column) //3
    islandSearchDFS(&grid, row, column-1) //3
    islandSearchDFS(&grid, row, column+1) //3
}

numIslands(islands)
