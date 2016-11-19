//: Playground - noun: a place where people can play

import UIKit

//: # Stack.

//: Check for balanced parentheses in an expression
//: Given an expression string exp, write a program to examine whether the pairs and the orders of “{“,”}”,”(“,”)”,”[“,”]” are correct in exp. For example, the program should print true for exp = “[()]{}{[()()]()}” and false for exp = “[(])”


var balancedTest = "()"
var unbalancedTest = "({([(])})"

//: ###Logic
//: Convert the String into an array of Character
//: Traverse the array of Characters
//: If the current Character is an opening bracket we push it into the stack.
//: If the current Character is a closing bracket we compare it with the bracket in top of the stack. If the stack is empty we return false Also if they don't match we return false. Meaning they are not balanced.
//: At the end of this process if there is a remaining Character in the stack it is not balanced and we return false if the stack is empty then it is true.
//: ### Time Complexity is O(n)
//: We iterate over all the items in the array checking for brackets so it is proportional to the array size. We are also using extra memory by creating a stack which is O(n) worst case scenario.

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
            stack.push(item: expression[i])
        }
        if expression[i] == "}" || expression[i] == ")" || expression[i] == "]" {
            if stack.isEmpty {
                return false
            } else if !isMatchingPair(character1: stack.pop(), character2: expression[i]) {
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
areParenthesisBalanced(expression: arrayOfCharacters)
var arrayOfCharacters2 = [Character](unbalancedTest.characters)
//areParenthesisBalanced(expression: arrayOfCharacters2)

//: 7. Find missing parenthesis in a given expression – 2 * ( 3 + 5(sasdfasdfasd)

func findMissingParenthesisIn(string: String) {
    var arrayOfCharacters = [Character](string.characters)
    var stack = Stack<Character>()
    for i in 0..<arrayOfCharacters.count {
        if arrayOfCharacters[i] == "(" {
            stack.push(item: arrayOfCharacters[i])
        }
        if arrayOfCharacters[i] == ")" {
            if stack.isEmpty {
                print("Missing opening paranthesis ( ")
            } else {
                stack.pop()
            }
        }
    }
    
    if !stack.isEmpty {
        print("Missing closing parenthesis )")
    }
}

findMissingParenthesisIn(string: "((())")

//: 8. Evaluate an expression given only single digits and only 2 operators * and +.

func evaluate(expression: String) {
    var expression = [Character](expression.characters)
    var sum = 0
    var valueStack = Stack<Int>()
    var operatorStack = Stack<Character>()
    var current = 0
    
    while current < expression.count {
        let currentCharacter = expression[current]
        if currentCharacter != "+" && currentCharacter != "*" {
            guard let value = Int(String(expression[current])) else { return }
            valueStack.push(item: value)
        } else if currentCharacter == "+" {
            operatorStack.push(item: currentCharacter)
        } else { // currentChar == "*"
            guard let currentNumberSucessor = Int(String(expression[current + 1])) else { return }
            valueStack.push(item: valueStack.pop() * currentNumberSucessor)
            current += 1
        }
        current += 1
    }
    while !valueStack.isEmpty {
        sum += valueStack.pop()
    }
}

evaluate(expression: "2+2*4")


