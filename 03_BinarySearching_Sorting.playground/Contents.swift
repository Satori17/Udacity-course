import UIKit

// - BINARY SEARCH

func binarySearch(_ array: [Int], value: Int) -> Int? {
    // Your code goes here
    guard array.count > 0 else { return nil }
    let minIndex = 0
    let maxIndex = array.count-1
    let midValue = array[maxIndex/2]
    
    if value < array[minIndex] || value > array[maxIndex] {
        return nil
    } else if value > midValue {
        return array.firstIndex(of: value)
    } else {
        return array.firstIndex(of: value)
    }
}

// Test cases
let testArray = [1, 3, 9, 11, 15, 19, 29]
let testVal1 = 25
let testVal2 = 15
//print(binarySearch(testArray, value: testVal1)) // Should be nil
//print(binarySearch(testArray, value: testVal2)!) // Should be 4



// - BUBBLE SORT

var array = [4,7,8,1,3,5]
let n = array.count
var swaps = 0
var swapped = false
for i in 0..<n {
    swapped = false
    for j in 0..<n-i-1 {
        guard array[j] > array[j + 1] else { continue }
        array.swapAt(j, j+1)
        swaps += 1
        swapped = true
    }
    guard swapped else { break }
}
//print(array)
//print(swaps)




// - RECURSION

// be sure to check the base case, and recursively call getFib
func getFib(_ position: Int) -> Int {
    // Your code goes here
    guard position > 1 else { return position }
    return getFib(position-1) + getFib(position-2)
}

//Test cases
//print(getFib(9)) // Should be 34
//print(getFib(11)) // Should be 89
//print(getFib(0)) // Should be 0



// - QUICK SORT

func quicksort(_ input: inout [Int], low: Int, high: Int) -> [Int] {
    // check the base case: low is less than high
    guard low < high else { return input }
    // select the pivot
    let pivot = input[high]
    var startIndex = low
    // perform the partitioning step
    for i in low..<high {
        if input[i] <= pivot {
            (input[startIndex], input[i]) = (input[i], input[startIndex])
            startIndex += 1
        }
    }
    // make the recursive call with the new high and low values
    (input[startIndex], input[high]) = (input[high], input[startIndex])
    input = quicksort(&input, low: low, high: startIndex-1)
    input = quicksort(&input, low: startIndex+1, high: high)
    
    return input
}

// Test case
var testingArray = [21, 4, 1, 3, 9, 20, 25, 6, 21, 14]
//print(quicksort(&testingArray, low: 0, high: testingArray.count - 1))


