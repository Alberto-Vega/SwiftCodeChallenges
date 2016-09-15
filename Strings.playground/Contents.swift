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
    let spaceCount = countSpaces(string)
    var newLength = string.characters.count + spaceCount * 2
    
    var largerString = String(count: newLength, repeatedValue: Character(" "))
    for character in string.characters.reverse() {
        print(character)
        if character == " " {
            largerString.insert("0", atIndex: largerString.endIndex.predecessor())
            largerString.insert("2", atIndex: largerString.endIndex.predecessor())
            largerString.insert("%", atIndex: largerString.endIndex.predecessor())
            newLength = newLength-3
        } else {
            largerString.insert(character, atIndex: largerString.startIndex.successor())
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

replaceSpaces(string)
print(string)
