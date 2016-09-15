//: Playground - noun: a place where people can play

import UIKit

//: # Stack.

//: 7. Find missing parenthesis in a given expression – 2 * ( 3 + 5(sasdfasdfasd)

var balancedTest = "()"
var unbalancedTest = "({([(])})"


func isMatchingPair(character1: Character, character2: Character) -> Bool {
    if character1 == "(" && character2 == ")" {
        return true
    } else if character1 == "{" && character2 == "}" {
        return true
    } else if character1 == "[" && character2 == "]" {
        return true
    } else {
        return false
    }
}

func areParenthesisBalanced(expression: [Character])-> Bool {
    var stack = Stack<Character>()
    for i in 0..<expression.count {
        if expression[i] == "{" || expression[i] == "(" || expression[i] == "[" {
            stack.push(expression[i])
        }
        if expression[i] == "}" || expression[i] == ")" || expression[i] == "]" {
            if stack.isEmpty {
                return false
            } else if !isMatchingPair(stack.pop(), character2: expression[i]) {
                return false
            }
        }
    }
    
    if stack.isEmpty {
        return true
    } else {
        return false
    }
}

var arrayOfCharacters = [Character](balancedTest.characters)
areParenthesisBalanced(arrayOfCharacters)
var arrayOfCharacters2 = [Character](unbalancedTest.characters)
areParenthesisBalanced(arrayOfCharacters2)

