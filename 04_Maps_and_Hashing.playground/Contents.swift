import Foundation

//prevention of log noises
import PlaygroundSupport
defer{ PlaygroundPage.current.finishExecution() }

//MARK: - MAPS

/*
 Cities to add:
 Bangalore (India, Asia)
 Atlanta (USA, North America)
 Cairo (Egypt, Africa)
 Shanghai (China, Asia)
 */


var locations = ["North America" : ["USA" : ["Mountain View"]]]

/*
 Print the following
 1. A list of all cities in the USA in
 alphabetical order. Hint: use the array sorted() method
 2. All cities in Asia, in alphabetical
 order, next to the name of the country.
 In your output, label each answer with a number
 so it looks like this:
 1
 American City
 American City
 2
 Asian City - Country
 Asian City - Country
 */

// Your code goes here

locations["Asia"] = ["India": ["Bangalore"]]
locations["North America"]?["USA"]?.append("Atlanta")
locations["Africa"] = ["Egypt": ["Cayro"]]
locations["Asia"]?["China"] = ["Shanghai"]


print("1")
for i in locations["North America"]!["USA"]!.sorted() {
    print(i)
}
print("2")

for i in locations["Asia"]! {
    print("\(i.key) - \(i.value[0])")
}
print("______________________________")
//for sorting and printint cities and countries in asia
var asiaCities = [String]()
for (country, cities) in locations["Asia"]! {
    let cityCountry = "\(cities[0]) - \(country)"
    
    asiaCities.append(cityCountry)
}
for city in asiaCities.sorted() {
    print(city)
}

print("_________________________________________________")


//MARK: - HASHING


class HashTable {
    
    var table: [[String]]
    
    init() {
        table = Array(repeating: [], count: 10000)
    }
    
    // use the helper functions to calulate the hash value, per the instructions
    func calculateHashValue(_ input: String) -> Int {
        if input.count > 0 {
            return (100 * getFirstCharacterValue(input)) + getSecondCharacterValue(input)
        }
        return 0
    }
    
    // store the input in the hash table, using the appropriate bucket
    func store(_ input: String) {
        if input.count > 0 {
                table[calculateHashValue(input)].append(input)
        }
    }
    
    // return true if the input string is stored in the hash table, otherwise return false
    func lookup(_ input: String) -> Bool {
        if table[calculateHashValue(input)].contains(input) {
            return true
        }
        return false
    }
    
    // gets the hash value of the first character
    func getFirstCharacterValue(_ input: String) -> Int {
        if input.count > 0 {
            return Int(input[input.startIndex].unicodeScalars.first!.value)
        }
        return 0
    }
    
    // gets the hash value of the second character
    func getSecondCharacterValue(_ input: String) -> Int {
        if input.count > 1 {
            return Int(input[input.index(after: input.startIndex)].unicodeScalars.first!.value)
        }
        // string does not have a second index
        return 0
    }
}

let hashTable = HashTable()

// these two have the same hash value
let string1 = "UDACITY"
let string2 = "UDACIOUS"
// different hash value
let string3 = "SWIFTASTIC"

hashTable.store(string1)
hashTable.store(string2)
hashTable.store(string3)

print(hashTable.lookup("SWIFT")) // false
print(hashTable.lookup("UDACIOUS")) // true
print(hashTable.lookup("UDACIAN")) // false
print(hashTable.lookup("SWIFTASTIC")) // true

//hashTable.calculateHashValue(string3)
