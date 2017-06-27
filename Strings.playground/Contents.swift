//: Playground - noun: a place where people can play

import UIKit


//: 3. Write a method to replace all spaces in a string with ‘%20’.

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

replaceSpaces(string: string)
print(string)


/*
 
 Given a string L representing the letter and a string N representing the newspaper, return true if the L can be written entirely from N and false otherwise.
 The letter includes only ascii characters.
 
 Language:Java
 Swap Roles End Interview

 Runtime Complexity: In the worst case we scan all of L and N linearly. For each character on the we do constant number of operations. Therefore, if m and n are the lengths of L and N, the runtime complexity is linear O(n+m).
 
 Space Complexity: Using the variable charCode is only to make the pseudocode above clearer and can be avoided (by using the value directly). Other than that, since we use an array of constant size (256) and a constant number of variable, the space complexity is O(1).
 */

//def isLoveLetterReproducible(L, M):
//charMap = int array of size
//charCount = 0
//
//for i from 0 to L.length:
//charCode = int(L.charAt(i))
//if (charMap[charCode] == 0):
//charCount++
//charMap[charCode]++
//
//for i from 0 to N.length:
//charCode = int(L.charAt(i))
//if (charMap[charCode] > 0):
//charMap[charCode]--
//if (charMap[charCode] == 0):
//charCount--
//if (charCount == 0):
//return true
//
//return false
