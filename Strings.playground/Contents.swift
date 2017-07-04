//: Playground - noun: a place where people can play

import UIKit

/*:
 Write a function that counts the number of words in a camelCase string.
 
    input:    							output:
 
	albertoVegaGonzalez                     3
	one										1
    twoWords								2
    ""										0
    nil										0
 
 
 Check each character for uppercase

 O(N) - time
 O(1) - space


 */

let camelCaseString = "twoWords"
let stringCharacters = String(camelCaseString).characters.map{ String($0) }

func countCamelCaseWords(string: String?) -> Int {
    if string == "" || string == nil {
        return 0
    }
    
    var counter = 1
    let charArray = string?.unicodeScalars.map {$0}
    let upperCase = NSCharacterSet.uppercaseLetters

    guard let characters = charArray else {
        return 0
    }
    
    for character in characters {
        
        if upperCase.contains(character) {
            counter += 1
        }
    }
    return counter
}

print(countCamelCaseWords(string: "albertoVega"))

/*:
 
 Write a function that checks if a string is a palindrome.
 
 
    "nan" is a palindrome, "a" is apalindrome, "nat" is not a palindrome
 
 
 
 Input    output
 
 nat	   false
 
 nan       true
 
 oacocao   true
 
 ""        true
 
 Brainstorming solutions
 
 Hash table: O(n) - time
             O(n) - space
 

 Two variables to traverse the array from start to end and from end to start.
 
 O(n) - time
 O(1) - space
 
 Same concept but using recursion.
 O(n) - time
 O(n) - space
 
 Reading from start or end its same so you could compare those characters in one pass withouth extra memory use.
 check ocurrences of each character had to be in even numbers
 unless it is an odd number lenght string then we can have one character with an uneven count.
 
 */

func findPalindrome(string: String) -> Bool {
    
    if string.characters.count < 2 {
        return true
    }
    
    var characters = Array(string.characters)
    
    var end = characters.count-1
    var start = 0
    
    while start < characters.count/2 {
        if characters[start] != characters[end] {
            return false
        }
        start += 1
        end -= 1
    }
    
    return true
}

print(findPalindrome(string: "tacocat"))


//: Write a method to replace all spaces in a string with ‘%20’.

//func replaceSpaces(string:[Character], length: Int) {
//    var string = string
////    var spaceCount = countSpaces(string)
//    var newLength = length + spaceCount * 2
//    var largerString = [Int](count: newLength, repeatedValue: 0)
//    
////    string[newLength] = "\0"
//    for i in (string.count-1).stride(through: 0, by: -1){
//        if string[i] == " " {
//            string[newLength-1] = "0"
//            string[newLength-2] = "2"
//            string[newLength-3] = "%"
//            newLength = newLength-3
//        } else {
//            string[newLength - 1] = string[i]
//            newLength = newLength - 1
//        }
//    }
//}

func replaceSpaces(string: String)-> String {
    var string = string
    let spaceCount = countSpaces(string: string)
    var newLength = string.characters.count + spaceCount * 2
    var largerString = String(repeating: " ", count: newLength)

    for character in string.characters.reversed() {
        print(character)
        if character == " " {
            largerString.insert("0", at: largerString.index(before: largerString.endIndex))
            largerString.insert("2", at: largerString.index(before:largerString.endIndex))
            largerString.insert("%", at: largerString.index(before:largerString.endIndex))
            newLength = newLength-3
        } else {
            largerString.insert(character, at: largerString.index(after:largerString.startIndex))
            newLength = newLength - 1
        }
    }
     string = largerString
    
    return string
}

// Helper function.
func countSpaces(string: String)-> Int {
    var spaceCount = 0
    for character in string.characters {
        if character == " " {
            spaceCount += 1
        }
    }
    return spaceCount
}




var string = "Hello World Again"
//var arrayString = [Character](string.characters)


print(replaceSpaces(string: string))


