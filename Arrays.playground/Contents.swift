
import Foundation

/*:
 You have an array of integers, and for each index you want to find the product of every integer except the integer at that index.
 Write a function getProductsOfAllIntsExceptAtIndex() that takes an array of integers and returns an array of the products.
 
 
 Input         Output
 
 [1,7,3,4]    [84, 12, 24, 21]
 
 Brainstorming solutions
 
 A brute force approach would use two loops to multiply the integer at every index by the integer at every nestedIndex, unless index == nestedIndex.
 
 O(n^2) - time complexity
 
 Greedy Approach
 
 O(n) - time
 O(n) - space
 
 */

enum ProductsOfOtherNumbersError: Error, CustomStringConvertible {
    case lessThanTwo
    
    var description: String {
        return "Getting the product of numbers at other indeices requires at least 2 numbers"
    }
}

func getProductsOfAllIntsExceptAtIndex(_ ints: [Int]) throws -> [Int] {

    guard ints.count >= 2 else {
        throw ProductsOfOtherNumbersError.lessThanTwo
    }
    // we make an array with the lenght of the input array to
    // hold our products
    var productsOfAllIntsExceptAtIndex = Array(repeating: 0, count: ints.count)
    
    // for each integer, we find the product of all integers
    // before it, storing the total product so far each time
    var productSoFar = 1
    for i in 0..<ints.count {
        productsOfAllIntsExceptAtIndex[i] = productSoFar
        productSoFar *= ints[i]
    }
    
    // for each integer, we find the product of all the integers
    // after it. since each index in pruducts already has the 
    // product of all the integers before it, now we're storing
    // the total product of all other integers
    productSoFar = 1
    for i in (0..<ints.count).reversed() {
        productsOfAllIntsExceptAtIndex[i] *= productSoFar
        productSoFar *= ints[i]
    }
    
    return productsOfAllIntsExceptAtIndex
}

    print(try getProductsOfAllIntsExceptAtIndex([1, 7, 3, 4]))
    
/*: 
 Given an array of integers where each value 1 <= x <= len(array), write a function that finds all the duplicates in the array.
 
 
 dups([1, 2, 3])    = []
 dups([1, 2, 2])    = [2]
 dups([3, 3, 3])    = [3]
 dups([2, 1, 2, 1]) = [1, 2]
 
 Brainstorming solutions
 
 Brute Force : O(N^2)
 
 Set: O(N) - time
      O(N) - space
 
 Sort: O(N log N)
       O(1)
 
 Encoding: O(N) - time
           O(1) - space
 
 
 So each number in the array can be equal or greater than one and equal or smaller than the array count (length).
 1 <= x <= len(array) it would look like this:
 
    [ 1, 2, 3, 4]
      0  1  2  3
 
 We can observe that there is a relationship of each number with it's index. If we deduct one from the value we will get it's "ideal index".
 
    calculate index of 1
 
        index = number - 1
        index = 1 - 1
        index = 0
 
    [ 1, 2, 3, 4]
      0 
 
 Since these numbers can only be positive. We will negate the number at the ideal index just to keep track of the numbers
 we have seen so far. Meaning that we will iterate over the array and every time we see a number:
 if the number at the encoding index is already negative we have a duplicate so we will add it to our set.
 else we will flip the sign of the number at its corresponding index.
 
 
     [-1, 1, 3, 4]
       0  1  2  3
       ^
 
    In the second step we see that encoding index is already negative so we have a duplicate.
 
    [-1, 1, 3, 4]
      0  1  2  3
         ^
 
 
 *source: http://www.byte-by-byte.com/findduplicates/

 */

// Return a list of duplicates in the array. To avoid using extra space,
// We flag whick elements we've seen before by negating the value at
// indexed at that value in the array.
func findDuplicates(array:[Int]) -> [Int] {
    if array.isEmpty {
        return array
    }
    
    var array = array
    var resultSet = Set<Int>()
    for currentIndex in 0..<array.count {
        // Translate the value into an index( 1 <= x <= array.count)
        let index = abs(array[currentIndex] - 1)
        //If the value at that index is negative, then we've already seen
        //that value so it's a duplicate. Otherwise, negate the value at
        //that index so we know we've seen it
        if array[index] < 0 {
            resultSet.insert(abs(array[currentIndex]))
        } else {
            array[index] = -array[index]
        }
        
    }
    // Return the array to it's original state.
    for index in 0..<array.count {
        array[index] = abs(array[index])
    }
    
    return Array(resultSet)
}

print(findDuplicates(array: [1, 2, 2, 3]))
print(findDuplicates(array: []))


/*: 
 Remove duplicate numbers from an array.
 
 Understanding the question: Need to clarify which kind of numbers are stored in the array.  If they are sorted or not. In this case we will be working with arrays of integers and the data is not sorted.
 
 Brainstorming solutions:
 
 Brute force solution.
 
 Compare each number in the array with the numbers ahead of it using two variables current and runner.
 
 Running time O(N^2)
 Pro: That is not using extra memory this solution will be using O(1) memory space.

 
 Better Solution.
 
 Use a simple hash table to keep track of duplicates.
 
 Pro: Running time will be O(N) since it touches each element in the array once.
 Cons: The use of extra memory. This solution will be using O(N) memory space.
 */

func removeDuplicates(numbers: [Int]) -> [Int] {
    if numbers.isEmpty || numbers.count == 1 {
        return numbers
    }
    
    var resultDictionary: [Int : Int] = Dictionary()
    
    for number in numbers {
        if resultDictionary[number] == nil {
            resultDictionary[number] = number
        }
    }
    return Array(resultDictionary.values.elements)
}

let testDuplicates = [1,2,3,3,4,5]

print(removeDuplicates(numbers: testDuplicates))

/*: Given an array of sorted distinct integers named arr, write a function that returns an index i in arr for which arr[i] = i or -1 if no such index exists.
 
           - Solution one time complexity is O(log n) since it's using binary search.
 */
func indexEqualsValueSearch(array: [Int]) -> Int {
    var start = 0
    var end = array.count - 1
    while start <= end {
        let index = (start +  end) / 2
        if array[index] - index < 0 {
            start = index + 1
        } else if array[index] - index == 0 {
            return index
        } else {
            end = index - 1
        }
    }
    return -1
}

let test = [-8,0,2,5]
indexEqualsValueSearch(array: test)

/*: Max Non Negative SubArray
 Find out the maximum sub-array of non negative numbers from an array.
 The sub-array should be continuous. That is, a sub-array created by choosing the second and fourth element and skipping the third element is invalid.
 
 Maximum sub-array is defined in terms of the sum of the elements in the sub-array. Sub-array A is greater than sub-array B if sum(A) > sum(B).
 
 Example:
 
 A : [1, 2, 5, -7, 2, 3]
 The two sub-arrays are [1, 2, 5] [2, 3].
 The answer is [1, 2, 5] as its sum is larger than [2, 3]
 NOTE: If there is a tie, then compare with segment's length and return segment which has maximum length
 NOTE 2: If there is still a tie, then return the segment with minimum starting index
*/
func maxNonNegativeSubArray(array: [Int]) -> [Int] {
    var maxSubArray = [Int]()
    var maxSum = 0
    var tempSum = 0
    var tempArray = [Int]()
    for number in array {
        if number > 0 {
            tempSum += number
            tempArray.append(number)
        } else {
            if tempSum > maxSum {
                maxSum = tempSum
                maxSubArray = tempArray
            }
        }
    }
    return maxSubArray
}

var a = [1, 2, 5, -7, 2, 3]
maxNonNegativeSubArray(array: a)


// MAx sub array solution
//  https://www.youtube.com/watch?v=ohHWQf1HDfU


/* Find the largest and second largest element in an array.
 Input:  arr[] = {12, 13, 1, 10, 34, 1}
output:  34, 13
 */

let sample = [100, 12,13,1,10,34]

func find2Largest(data: Array<Int>) -> (Int, Int) {
    var first = Int.min
    var second = Int.min
    for i in 0...data.count - 1 {
        if data[i] > first {
            second = first
            first = data[i]
        } else if data[i] > second  {
            second = data[i]
        }
    }
    return (first,second)
}

find2Largest(data: sample)

/* Find the largest element in an array.
 Input:  arr[] = {12, 13, 1, 10, 34, 1}
 output:  34, 13
 */

func findLargest(data: Array<Int>) -> Int {
    var largest = 0
    for i in 0...data.count-1 {
        if data[i] > largest {
            largest = data[i]
        }
        
    }
    return largest
}

findLargest(data: sample)
