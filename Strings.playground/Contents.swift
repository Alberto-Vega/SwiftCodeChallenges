//: Playground - noun: a place where people can play

import UIKit

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



