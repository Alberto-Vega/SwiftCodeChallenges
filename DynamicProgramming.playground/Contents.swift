//: Playground - noun: a place where people can play

import UIKit

/*: Given a keypad as shown in diagram, and a n digit number, list all words which are possible by pressing these numbers.
 
 For example if input number is 234, possible words which can be formed are (Alphabetical order):
 adg adh adi aeg aeh aei afg afh afi bdg bdh bdi beg beh bei bfg bfh bfi cdg cdh cdi ceg ceh cei cfg cfh cfi
 */

let hashTable:[[Character]] = [[" "],[" "], ["a","b","c"], ["d","e","f"], ["g","h","i"], ["j","k","l"], ["m","n","o"], ["p","q","r","s"], ["t","u","v"], ["w","x","y","z"]]

func printWordsUtil(number: [Int], currentDigit: Int, output: [Character], n: Int) {
    var output = output
    if (currentDigit == n)
    {
        print(output)
        return
    }
    
    for index in 0..<hashTable[number[currentDigit]].count {
        output[currentDigit] = hashTable[number[currentDigit]][index]
        printWordsUtil(number, currentDigit: currentDigit+1, output: output, n: n)
        if number[currentDigit] == 0 || number[currentDigit] == 1 {
            return
        }
    }
}

func printWords(number: [Int], n: Int)
{
    var result = [Character](count:n, repeatedValue: " ")
    printWordsUtil(number, currentDigit: 0, output: result, n: n)
}

var number = [2,3,4]
//printWords(number, n: number.count)

/* Question 1: You are given a phone keypad like following diagram, where each character corresponds to a digit mentioned in the same box.
 You are given n strings and you have to find their decimal representation. You have to print the string and corresponding decimal representation in descending order.
 Like if you are given “amazon” then its corresponding decimal notation will be 262966.
 If more than one strings have same decimal notation then you have to print them in the order in which input is given.
 (Given that given string consists of lower case alphabets only.)*/

var characterValues:[Character: Int] = ["a": 2, "b": 2, "c": 2, "d": 3, "e": 3, "f": 3, "g": 4, "h": 4, "i": 4, "j": 5, "k": 5, "l": 5, "m": 6, "n": 6, "o": 6, "p": 7, "q": 7, "r": 7, "t": 8, "u": 8, "v": 8, "w": 9, "x": 9, "y": 9, "z": 9]

func convertToNumber(string:String) {
    var numericValue = Array(count: string.characters.count, repeatedValue: 0)
    for character in string.characters.enumerate() {
        guard let number = characterValues[character.element] else { return }
        numericValue[character.index] = number
    }
    print("the numeric value for: \(string) is \(numericValue)")
}

var input = "amazon"
//convertToNumber(input)

/*: 6. Given two sequences, print longest common subsequence LCS for input Sequences “ABCDGH” and “AEDFHR” is “ADH” of length 3. LCS for input Sequences “AGGTAB” and “GXTXAYB” is “GTAB” of length 4.
 */

//: This one just returns the length it doesn't print the word.

func longestCommonSubsequenceLength(string1: [Character], string2: [Character], length1: Int, length2: Int) -> Int {
    var L = [[Int]](count:length1+1, repeatedValue: [Int](count: length2+1, repeatedValue: 0))
    // Iterate columns of the 2D Array or matrix.
    for i in 0..<L.count
    {
        // Iterate rows of the 2D Array or matrix.
        for j in 0..<L[i].count
        {
            if(i == 0 || j == 0)
            {
                L[i][j] = 0
            }
            else if string1[i-1] == string2[j-1]
            {
                L[i][j] = L[i-1][j-1] + 1
            }
            else
            {
                L[i][j] = max(L[i-1][j], L[i][j-1])
            }
        }
    }
    return L[length1][length2]
}

// Gets the length and print the subsequence.
func longestCommonSubsequence(string1: [Character], string2: [Character], length1: Int, length2: Int) {
    var L = [[Int]](count:length1+1, repeatedValue: [Int](count: length2+1, repeatedValue: 0))
    // Iterate columns of the 2D Array or matrix.
    for i in 0..<L.count
    {
        // Iterate rows of the 2D Array or matrix.
        for j in 0..<L[i].count
        {
            if(i == 0 || j == 0)
            {
                L[i][j] = 0
            }
            else if string1[i-1] == string2[j-1]
            {
                L[i][j] = L[i-1][j-1] + 1
            }
            else
            {
                L[i][j] = max(L[i-1][j], L[i][j-1])
            }
        }
    }
    var index = L[length1][length2]
    var lcs = [Character](count:index, repeatedValue: " ")
    
    var i = string1.count
    var j = string2.count
    
    while i > 0 && j > 0
    {
        // If chars are equal
        if string1[i-1] == string2[j-1]
        {
           lcs[index-1] = string1[i-1]
            i-=1; j-=1; index -= 1
        }
        // If not find greater value and to that direction.
        else if L[i-1][j] > L[i][j-1]
        {
            i-=1
        }
        else
        {
            j-=1
        }
    }
    print("LCS of \(string1) and \(string2) is \(lcs)")
}

let string1:[Character] = ["A","G","G","T","A","B"]
let string2: [Character] = ["G","X","T","X","A","Y","B"]

longestCommonSubsequence(string1, string2: string2, length1: string1.count, length2: string2.count)

print("Length of LCS is \(longestCommonSubsequenceLength(string1, string2: string2, length1: string1.count, length2: string2.count))")

/*: 7. Given two string str1 and str2, find the shortest string that has both str1 and str2 as subsequences. Examples:
 Input: str1 = “geek”, str2=”eke”
 Output: “geeke”
 Input: str1 = “AGGTAB”, str2=”GXTXAYB”
 Output: “AGXGTXAYB”
 */

func superSeq(x: [Character], y: [Character], m: Int, n: Int) -> Int {
    var dp = [[Int]](count:m + 1, repeatedValue: [Int](count: n+1, repeatedValue: 0))
    // Iterate columns of the 2D Array or matrix.
    for i in 0..<dp.count {
        // Iterate rows of the 2D Array or matrix.
        for j in 0..<dp[i].count {
        
            if i == 0 || j == 0 {
                dp[i][j] = 0
            }
            else if x[i-1] == y[j-1] {
                dp[i][j] = 1 + dp[i-1][j-1]
            }
            else {
                dp[i][j] = 1 + min(dp[i-1][j], dp[i][j-1])
            }
        }
    }
    return dp[m][n]
}

let x:[Character] = ["g","e","e","k"]
let y:[Character] = ["e","k","e"]

print("Length of the shortest supersequence is \(superSeq(x, y: y, m: x.count, n: y.count))")
