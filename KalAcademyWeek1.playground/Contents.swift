//: #Arrays

import UIKit
/*:
1. Given a sorted array in which all elementes appear twice(one after one) and one element appears only once. Find that element in O(log n) complexity.
*/
//: Test Cases:

//: Input:
var array1 = [1,1,3,3,4,5,5,7,7,8,8]
//: Output: 4

//: Input:
var array2 = [1,1,3,3,4,4,5,5,7,7,8]
//: Output: 8

//: Input:
var array3 = [1,1,3,4,4,5,5,7,7]
//: Output: 8

var array4 = [1,1,2,2,3,4,4,5,5]

func search(array: [Int], low: Int, high: Int)
{
    //Base cases
    if low > high
    {
        print("No element that appears only once was found")
     return
    }
    
    if low == high {
        print("The required element is \(array[low])")
        return
    }
    
    //Find the midle point.
    let mid = low + (high - low) / 2
    // If mid is even and element next to mid is same as mid, then output element lies on the right side, else on left side.
    if (mid%2 == 0)
    {
        if(array[mid] == array[mid+1])
        {
            search(array: array, low: mid + 2, high: high)
        } else {
            search(array: array, low: low, high: mid)
        }
    }
    else // if mid is odd.
    {
       if (array[mid] == array[mid - 1])
       {
        search(array: array, low: mid + 1 , high: high)
        }
       else
       {
        search(array: array, low: low, high: mid - 1)
        }
    }
}

//search(array: array1, low: 0, high: array1.count - 1)
//
//search(array: array2, low: 0, high: array2.count - 1)
//
//search(array: array3, low: 0, high: array3.count - 1)
//search(array: array4, low: 0, high: array4.count - 1)

/*:
2. A magic index in an array A[0…n-1] is defined to be an index such that A[i] = i. Given a sorted array of distinct integers, write a method to find a magic index if one exists, in an array A. FOLLOW UP: What if the values are not distinct?
 */
// Input
var array = [-5, -1, 0, 1, 4, 7]

func binarySearch(array: [Int], low: Int, high: Int) -> Int {
    if (high >= low) {
        let mid = low + (high - low)/2
        if mid == array[mid] {
            return mid
        }
        if mid > array[mid] {
            return binarySearch(array: array, low: mid + 1, high: high)
        } else {
            return binarySearch(array: array, low: low, high: mid - 1)
        }
    }
    return -1
}

//var resultBinary = binarySearch(array: array, low: 0, high: array.count - 1)

func magicNonDistinct(array: [Int], start: Int, end: Int) -> Int {
    Swift.print("Start: \(start) end: \(end)")
    if start > end {
     return -1
    }
    let mid = start + (end - start) / 2
    if mid < 0 || mid >= array.count {
        return -1
    }
    
    let v = array[mid]
    if v == mid { return mid }
    
    let leftEnd = min(v,mid-1)
    let leftRes = magicNonDistinct(array: array, start: start, end: leftEnd)
    if leftRes != -1 { return leftRes }
    
    let rightStart = max(v, mid+1)
    let rightRes = magicNonDistinct(array: array, start: rightStart, end: end)
    return rightRes
    
}

//var result = magicNonDistinct(array: array, start: 0, end: array.count-1)

/*:
 3. Given a sorted array of n integers that has been rotated an unknown number of times, write code to find an element in the array. You may assume that the array was originally sorted in increasing order.
 */
func  findElementInRotatedArray(array: [Int], x: Int) -> Int {
    var low = 0, high = array.count-1
    while low <= high {
//        Swift.print("low: \(low) high \(high)")
        let mid = low + (high - low) / 2
        // mid element is equal to x.
        if array[mid] == x {
            return mid
        }
        
        if array[mid] <= array[high] { // right half is sorted.
            if x >= array[mid] && x <= array[high] {
                low = mid + 1
            } else {
                high = mid - 1
            }
        } else // array[low] <= array[mid] left side is sorted.
        {
           if x >= array[low] && x <= array[mid] // if x is within this segment continue binary search
            {
                high = mid - 1
           } else // if not binary search on the right side.
           {
            low = mid + 1
            }
        }
        
    }
    return -1
}

var rotated = [12,14,18,21,3,6,8,9]
var rotated2 = [-3,-2,-1,1,3,6,7,8,-5]
let result1 = findElementInRotatedArray(array: rotated, x: 9)
//print("The x element is at index: \(result1)")
//
//let result2 = findElementInRotatedArray(array: rotated2, x: -5)
//print("The x element is at index: \(result2)")


//: 4. Given an array that contains numbers from 1 to n-1 and exactly 1 duplicate, find that duplicate.

var array5 = [1,1,2,3,4,5]
var array6 = [1,2,3,4,5,5]

func swap( array: inout [Int], index1:Int, index2: Int) {
    let temp = array[index1]
    array[index1] = array[index2]
    array[index2] = temp
}

func findDuplicateElement( array: inout [Int]) -> Int {
    let lastIndex = array.count-1
    
    while array[array[lastIndex]-1] != array[lastIndex] {
        swap(array: &array, index1: array[array[lastIndex]-1], index2: array[lastIndex])
    }
    return array[array[lastIndex]-1]
}

//print("The duplicated element in an array with elements from 1 to n-1: \(findDuplicateElement(array: &array5))")
//print("The duplicated element in an array with elements from 1 to n-1: \(findDuplicateElement(array: &array6))")

//: Solution with mathematical formula.

var arrayWithDuplicate = [4,1,3,4,2]

func findDuplicateElementFormula(array: [Int]) -> Int{
    var currentArraySum = 0
    var uniqueNumbersArraySum = 0
    //Add all the elements in the array
    for number in array {
        currentArraySum += number
    }
    //Add the numbers from 1 to n-1.
    
    for number in 1..<array.count {
        uniqueNumbersArraySum += number
    }
    return currentArraySum - uniqueNumbersArraySum
}

//print("The duplicated element in an array with elements from 1 to n-1 using formula: \(findDuplicateElementFormula(array: arrayWithDuplicate))")

/*: 5. Search an element in an array where difference between adjacent elements is 1.

For example: arr[] = {8, 7, 6, 7, 6, 5, 4, 3, 2, 3, 4, 3}

Search for 3 and Output: Found at index 7
*/

func findElement(array: [Int], x: Int) {
    var current = 0
    while array[current] != x && current < array.count {
            if array[current] >  x {
                current = current + array[current] - x
            } else {
                current = current + x - array[current]
            }
            Swift.print(current)
    }
    if array[current] == x {
        print("Found at index \(current)")
    } else {
        print("Element \(x) not found")
    }
}
var input = [8, 7, 6, 7, 6, 5, 4, 3, 2, 3, 4, 3]
var input2 = [2,3,4,3,2,3,4]

//findElement(input, x: 3)
//findElement(input2, x: 4)

/*:
 6. Given an array of numbers, split the array into two where one array contains the sum of n-1 numbers and the other array with all the n-1 elements.
 */

var testInput = [1,2,7,10]



//: Assuming the input is sorted it will return two arrays.

enum WrongInputError: Error {
    case NotDivisible
}

//: helper function.
func arraySum(array:[Int]) -> Int {
    var sum=0
    for number in array {
        sum += number
    }
    return sum
}

func split( array:inout [Int]) throws ->([Int], [Int]) {
    var sum = array.reduce(0, +)
    guard sum % 2 == 0 else { throw WrongInputError.NotDivisible }
    let halfSum = sum/2
    var subSet1 = [Int]()
    var subSet2 = [Int]()
    for index in 0..<array.count {
        if sum > halfSum {
            subSet1.append(array[index])
            sum -= array[index]
        } else  {
            subSet2.append(array[index])
        }
    }
    return (subSet1, subSet2)
}

//var finalResult = try split(array: &testInput)
//print(finalResult.0)
//print(finalResult.1)
//
//var finalResult2 = try split(array: &input2)
//for i in 0..<finalResult2.0.count {
//    Swift.print(finalResult2.0[i])
//}


//: # Strings
//: 1. Implement an algorithm to determine if a string has all unique characters. What if you cannot use additional data structures?

//: Using a dictionary.

func isUniqueChars(string: String) -> Bool {
    if string.characters.count > 128 {
        return false
    }
    var charFlags = [String : Bool]()
    for item in string.characters.enumerated() {
        if (charFlags[(String(item.element))] != nil) {
            return false
        }
        charFlags[(String(item.element))] = true
        Swift.print(item.element)
    }
    return true
}
//: Using the unicode scalar representation since these unicode scalars represent ASCII characters.

func isUniqueChars1(string: String) -> Bool {
    if string.characters.count > 128 {
        return false
    }
    var characterFlags = [Bool](repeating:false, count:128)
    
    for scalar in string.unicodeScalars {
        let value = scalar.value
        let intValue = Int(value)
        if characterFlags[intValue] {
            return false
        }
        characterFlags[intValue] = true
    }
    return true
}


//let strings = ["abcde", "hello", "apple", "kite", "padle"]
//for string in strings {
//    Swift.print("\(string): \(isUniqueChars(string: string)) \(isUniqueChars1(string: string))")
//    var result =
//        isUniqueChars(string: string)
//    var result1 = isUniqueChars1(string: string)
//}

//: 2. Given two strings, write a method to decide if one is a permutation of the other?

//: Solution #1: sorting.

func permutation(string1: String, string2: String) -> Bool {
    if string1.characters.count != string2.characters.count {
        return false
    }
    return sort(string: string1) == sort(string: string2)
}

func sort(string: String) -> String {
    let content = [Character](string.characters)
    return String(content.sorted(){$0 < $1})
}

//: Solution #2:
func permutation2(string1: String, string2: String) -> Bool {
    if string1.characters.count != string2.characters.count {
        return false
    }
    
    var letters = [Int](repeating: 0, count:128)
    
    for scalar in string1.unicodeScalars {
        let value = scalar.value
        let intValue = Int(value)
        letters[intValue] += 1
    }
    
    for scalar in string2.unicodeScalars {
        let value = scalar.value
        let intValue = Int(value)
        Swift.print("\(value)")
        letters[intValue] -= 1
        if letters[intValue] < 0 {
            return false
        }
    }
    return true
}

//: Lets test both solutions:


//let stringPairs = [("dog", "god"), ("abc", "bac"), ("xyz", "yyz")]
//
//for pair in stringPairs {
//    permutation(string1: pair.0, string2: pair.1)
//    permutation2(string1: pair.0, string2: pair.1)
//}

//: 3. Write a method to replace all spaces in a string with ‘%20’.

func replaceSpaces(string:[Character], length: Int) {
    var string = string
    var spaceCount = 0
    for i in 0..<string.count {
        if string[i] == " " {
            spaceCount += 1
        }
    }
    
    var newLength = length + spaceCount * 2
    
    string[newLength] = "\0"
    for i in string.count-1...0 {
        if string[i] == " " {
            string[newLength-1] = "0"
            string[newLength-2] = "2"
            string[newLength-3] = "%"
            newLength = newLength-3
        } else {
            string[newLength - 1] = string[i]
            newLength = newLength - 1
        }
    }
}

var string = "Hello World Again"
var arrayString = [Character](string.characters)

//replaceSpaces(string: arrayString, length: arrayString.count-1)
//print(arrayString)

//: 4. Implement a method to perform a basic string compression using the counts of repeated characters. For example, the string aabccccaaa would become a2b1c4a3. If the compressed string would not become smaller than the original string, your method should return the original string.

func compress(string: String) -> String {
    var compressedString = String()
    var countConsecutive = 0
    var counter = 0
    for char in string.characters.indices {
        countConsecutive += 1
        counter += 1
       if counter >= string.characters.count ||
        string[char] != string[string.index(after: char)] {
            compressedString += "\(string[char])" + "\(countConsecutive)"
            countConsecutive = 0
        }
    }
    return compressedString.characters.count < string.characters.count ? compressedString : string
}

//: Lets test it:

//var example = "aabbcccca"
//var testResult = compress(string: example)
//print("compressed string is: \(testResult)")

//: 5. Write an algorithm such that if an element in an MxN matrix is 0, its entire row and column are set to 0.

func setZeros( matrix: inout [[Int]]) {
    var rowHasZero = false
    var columnHasZero = false
    
    //:Check if the first row has a zero.
    for j in 0..<matrix[0].count {
        if matrix[0][j] == 0 {
            rowHasZero = true
            break
        }
    }
    
    //:Check if first column has a zero.
    for i in 0..<matrix.count {
        if matrix[i][0] == 0 {
            columnHasZero = true
            break
        }
    }
    
    //:Check for zeros in the rest of the array.
    for i in 1..<matrix.count {
        for j in 1..<matrix.count {
            if matrix[i][j] == 0 {
                matrix[i][0] = 0
                matrix[0][j] = 0
            }
        }
    }
    
    //:Nullify rows based on values in first column.
    
    
    func nullifyRow( matrix:inout [[Int]], row: Int) {
        for j in 0..<matrix[0].count {
            matrix[row][j] = 0
        }
    }
    
    for i in 1..<matrix.count {
        if matrix[i][0] == 0 {
            nullifyRow(matrix: &matrix, row: i)
        }
    }
    
    //: Nullify columns based on values in first row.
    
    func nullifyColumn( matrix:inout [[Int]], column: Int) {
        for i in 0..<matrix.count {
            matrix[i][column] = 0
        }
    }
    
    for j in 1..<matrix[0].count {
        if matrix[0][j] == 0 {
            nullifyColumn(matrix: &matrix, column: j)
        }
    }
    
    //: Nullify first row.
    if rowHasZero {
        nullifyRow(matrix: &matrix, row: 0)
    }
    //: Nullify first column.
    if columnHasZero {
        nullifyColumn(matrix: &matrix, column: 0)
    }
}

//: Lets test it:
var testMatrix = [[1,0,1,1],
                  [1,1,1,1],
                  [1,0,1,1],
                  [1,0,1,1]]

setZeros(matrix: &testMatrix)

func printMatrix(matrix: [[Int]]) {
    for row in 0..<matrix.count {
        for column in 0..<matrix[row].count {
            Swift.print(matrix[row][column], terminator: "  ")
        }
        Swift.print("")
    }
}

//printMatrix(matrix: testMatrix)







