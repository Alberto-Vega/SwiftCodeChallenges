
import Foundation
/*:
 You decide to test if your oddly-mathematical heating company is fulfilling its All-Time Max, Min, Mean and Mode Temperature Guarantee™.
 Write a class TempTracker with these methods:
 
 insert()—records a new temperature
 getMax()—returns the highest temp we've seen so far
 getMin()—returns the lowest temp we've seen so far
 getMean()—returns the mean of all temps we've seen so far
 getMode()—returns a mode of all temps we've seen so far
 Optimize for space and time. Favor speeding up the getter functions getMax(), getMin(), getMean(), and getMode() over speeding up the insert() function.
 
 getMean() should return a double, but the rest of the getter methods can return integers. Temperatures will all be inserted as integers. We'll record our temperatures in Fahrenheit, so we can assume they'll all be in the range 0..110.
 
 If there is more than one mode, return any of the modes.
 
 */
struct Constants {
    
static let maxTemperature =  110
}

class TempTracker {
    // for mode
    private var occurrences = Array(repeating: 0, count: Constants.maxTemperature + 1) // array of 0s at indices 0..110
    private var maxOcurrences = 0
    var mode: Int?
    
    //for mean
    private var totalNumbers = 0
    private var totalSum = 0.0
    //mean should be double
    var mean: Double?
    
    // for min and max
    var minTemp:Int?
    var maxTemp:Int?
    
    func insert(temperature: Int) -> Bool {
        // for mode
        occurrences[temperature] += 1
        
        if occurrences[temperature] > maxOcurrences {
            mode = temperature
            maxOcurrences = occurrences[temperature]
        }
        
        // for mean
        totalNumbers += 1
        totalSum += Double(temperature)
        mean = totalSum / Double(totalNumbers)
        
        // for min and max
        if let maxTemp = maxTemp {
            self.maxTemp = max(maxTemp, temperature)
        } else {
            self.maxTemp = temperature
        }
        
        if let minTemp = minTemp {
            self.minTemp = min(minTemp, temperature)
        } else {
            self.minTemp = temperature
        }
        
        return true
    }
    
    func getMax() -> Int? {
        return maxTemp
    }
    
    func getMin() -> Int? {
        return minTemp
    }
    
    func getMean() -> Double? {
        return mean
    }
    
    func getMode() -> Int? {
        return  mode
    }
}

//: Testing

//let tempTracker = TempTracker()
//let temperatureReadings = [ 1, 3, 6, 3, 1, 3 ]
//
//for currentTemperature in temperatureReadings {
//    tempTracker.insert(temperature: currentTemperature)
//}
//print(tempTracker.getMax() ?? "unable to calculate max")
//print(tempTracker.getMin() ?? "unable to calculate min")
//print(tempTracker.getMean() ?? "unable to calculate mean")
//print(tempTracker.getMode() ?? "unable to calculate mode")


/*:
Rectangular Love

*/


struct Rectangle: CustomStringConvertible {
    
    // coordinates of bottom left corner
    let leftX: Int
    let bottomY: Int
    
    // dimensions
    let width: Int
    let height: Int
    
    init(leftX: Int, bottomY: Int, width: Int, height: Int) {
        self.leftX = leftX
        self.bottomY = bottomY
        self.width = width
        self.height = height
    }
    
    init() {
        self.init(leftX: 0, bottomY: 0, width: 0, height: 0)
    }
    
    var description: String {
        return String(format: "(%d, %d, %d, %d)", leftX, bottomY, width, height)
    }
}

// compare both rectangles and determine the leftmost which is the smaller x coordinates (x coordinates start closer to 0)
// create a new rectangle instance
// calculate it's x coordinates to the leftmost x coordinate
// calculate  it's width to the leftmost width minus right most x value.

func findOverlapingRectangle(rectangle1: Rectangle, rectangle2: Rectangle) -> Rectangle? {
    
    guard let xOverlap = findRangeOverlap(point1: rectangle1.leftX, length1: rectangle1.width, point2: rectangle2.leftX, length2: rectangle2.width),
          let yOverlap = findRangeOverlap(point1: rectangle1.bottomY, length1: rectangle1.height, point2: rectangle2.bottomY, length2: rectangle2.height) else {
            return nil
    }
    
    return Rectangle(leftX: xOverlap.startPoint, bottomY: yOverlap.startPoint, width: xOverlap.length, height: yOverlap.length)
}

struct RangeOverlap {
    let startPoint: Int
    let length: Int
}

func findRangeOverlap(point1: Int, length1: Int,
                      point2: Int, length2: Int) -> RangeOverlap? {
    
    guard let overlapLength = findOverlappingSideSize(point1: point1, length1: length1, point2: point2, length2: length2) else {
        return nil
    }
    
    let highestStartPoint = findOverlapPoint(point1: point1, point2: point2)
    
    return RangeOverlap(startPoint: highestStartPoint, length: overlapLength)
}

func findOverlapPoint(point1: Int, point2: Int) -> Int {
    return max(point1, point2)
}

func findOverlappingSideSize(point1: Int, length1: Int, point2: Int, length2: Int) -> Int? {
    
    let lineOneEndPoint = point1 + length1
    let lineTwoEndPoint = point2 + length2
    
    let lowestLineEndPoint = min(lineOneEndPoint, lineTwoEndPoint)
    let highestStartPoint = max(point1, point2)
   // This part handles the case that if both of the sides touches but the overlap size is 0 
   // returns nil since there is no point of having a 0 sized rectangle.
    guard highestStartPoint < lowestLineEndPoint  else {
        return nil
    }
    return lowestLineEndPoint - highestStartPoint
}

// Testing helper functions
//print(findOverlappingSideSize(point1: 0, length1: 2, point2: 1, length2: 3) ?? "There was no overlap on this side")
//print(findOverlappingSideSize(point1: 0, length1: 3, point2: 3, length2: 2) ?? "There was no overlap on this side")

//print(findOverlapPoint(point1: 0, point2: 1))
//print(findOverlapPoint(point1: 0, point2: 3))

let rectangleOne = Rectangle(leftX: 0, bottomY: 0, width: 4, height: 2)
let rectangleTwo = Rectangle(leftX: 3, bottomY: 1, width: 2, height: 3)

//print(findOverlapingRectangle(rectangle1: rectangleOne, rectangle2: rectangleTwo) ?? "No overlap found")

func changePossibilitiesBottomUp(amount: Int, denominations: [Int]) -> Int {
    
    var waysOfDoingNCents = Array(repeating: 0, count: amount + 1) // array of zeros from 0..amount
    waysOfDoingNCents[0] = 1
    
    for coin in denominations {
        if coin <= amount {
            for higherAmount in coin...amount {
                let higherAmountRemainder = higherAmount - coin
                waysOfDoingNCents[higherAmount] += waysOfDoingNCents[higherAmountRemainder]
            }
        }
    }
    
    return waysOfDoingNCents[amount]
}

//changePossibilitiesBottomUp(amount: 4, denominations: [1,2,3])

/*:
 
 Your company built an in-house calendar tool called HiCal. You want to add a feature to see the times in a day when everyone is available.
 To do this, you’ll need to know when any team is having a meeting. In HiCal, a meeting is stored as an instance of a Meeting class with integer properties startTime and endTime. These integers represent the number of 30-minute blocks past 9:00am.
 */

class Meeting: CustomStringConvertible {
    
    var startTime: Int
    var endTime: Int
    
    init(startTime: Int, endTime: Int) {
        
        // number of 30 min blocks past 9:00 am
        self.startTime = startTime
        self.endTime = endTime
    }
    
    var description: String {
        return "(\(startTime), \(endTime))"
    }
}

func mergeRanges(in meetings: [Meeting]) -> [Meeting] {
    // sort by start times
    let sortedMeetings = meetings.sorted() { $0.startTime < $1.startTime }
    // initialize mergedMeetings with the earliest meeting.
    var mergedMeetings = [sortedMeetings[0]]
    
    for i in 1..<sortedMeetings.count {
        let currentMeeting = sortedMeetings[i]
        let lastMergedMeeting = mergedMeetings[mergedMeetings.count - 1]
        
        // if the current and last meetings overlap, use the latest end time
        if currentMeeting.startTime <= lastMergedMeeting.endTime {
            lastMergedMeeting.endTime = max(lastMergedMeeting.endTime, currentMeeting.endTime)
        } else {
            // add the current meeting since it doesn't overlap
            mergedMeetings.append(currentMeeting)
        }
    }
    return mergedMeetings
}

//: Test.

//let result = mergeRanges(in:   [
//    Meeting(startTime: 0, endTime: 1), Meeting(startTime: 3, endTime: 5),
//    Meeting(startTime: 4, endTime: 8), Meeting(startTime: 10, endTime: 12),
//    Meeting(startTime: 9, endTime: 10)])

//for meeting in result {
//        print(meeting)
//}


/*:
 Mini-Max Sum Hackerrank
 Given five positive integers, find the minimum and maximum values that can be calculated by summing exactly four of the five integers. Then print the respective minimum and maximum values as a single line of two space-separated long integers.
 
 Input Format
 
 A single line of five space-separated integers.
 
 Constraints
 
 Each integer is in the inclusive range [1,10^9].
 Output Format
 
 Print two space-separated long integers denoting the respective minimum and maximum values that can be calculated by summing exactly four of the five integers. (The output can be greater than 32 bit integer.)
 
 Sample Input
 
 1 2 3 4 5
 Sample Output
 
 10 14
 Explanation
 
 Our initial numbers are 1, 2, 3, 4, and 5. We can calculate the following sums using four of the five integers:
 
 If we sum everything except 5, our sum is 1+2+3+4=10.
 If we sum everything except 4, our sum is 1+2+3+5=11.
 If we sum everything except 3, our sum is 1+2+4+5=12.
 If we sum everything except 2, our sum is 1+3+4+5=13.
 If we sum everything except 1, our sum is 2+3+4+5=12.
 As you can see, the minimal sum is 10 and the maximal sum is 14. Thus, we print these minimal and maximal sums as two space-separated integers on a new line.
 
 Hints: Beware of integer overflow! Use 64-bit Integer.
 
 We can minimize the sum by excluding the largest element from the sum.
 We can maximize the sum by excluding the smallest element from the sum.
 
 So we can just find min and max number and substract them from the total sum so we can find the total.
 
 */

func minMaxSum(numbers:[Int]) {
    if numbers.count < 5 {
        return
    }
    // create a min and max variables and set them to the first item in the array.
    // These will keep track of the smallest and largest numbers.
    // create a totalSum variable to sum all the numbers in the array

    var minimum = numbers[0], maximum = numbers[0], totalSum = 0
// Iterate the array and at each step:
    for number in numbers {
        // Add the current number to the totalSum.
        totalSum += number
        // compare the current number to min and max variables and update
        // them if necessary.

        minimum = min(minimum, number)
        maximum = max(maximum, number)
    }
    print("\(totalSum-maximum) \(totalSum-minimum)")
}

//minMaxSum(numbers: [1,2,3,4,5])

/*:
 Highest Product of 3
 
Given an array of integers, find the highest product you can get from three of the integers.
 
 
 Input                      Output
 
 [1,2,3,4,5]                    60
 []                             0
 [-10, -10, 1, 3 , 2]           300
 
 Brainstorming solutions
 
 Brute Force
 
 O(n^3) - time complexity
 
 Sorting the Array
 
 O(n log n)
 
 Greedy Approach
 
 O(n) - time
 O(1) - space
 
 for the complete explanation check:
 
 https://www.interviewcake.com/question/swift/highest-product-of-3
 
 */


enum HighestProductError: Error, CustomStringConvertible {
    case lessThanThree
    
    var description: String {
        return "Less than 3 items!"
    }
}

func highestProductOf3(_ items: [Int]) throws -> Int {
    guard items.count >= 3 else {
        throw HighestProductError.lessThanThree
    }
    
    // We're going to start at the 3rd item (at index 2)
    // so pre-populate highests and lowests based on the first 2 items,
    // we could also start these as null and check below if they're set
    // but this is arguably cleaner
    
    var highest = max(items[0], items[1])
    var lowest = min(items[0], items[1])
    
    var highestProductOf2 = items[0] * items[1]
    var lowestProductOf2 = items[0] * items[1]
    
    // except this one-- we pre-populate it for the first /3/ items.
    // this means in our first pass it'will check against itself, which is fine.
    var highestProductOf3 = items[0] * items[1] * items[2]
    // walk through items, starting at index 2
    
    for i in 2..<items.count {
        let current = items[i]
        
        // do we have a new highest product of 3?
        // it's either the current highest,
        // or the current times the highest product of two
        // or the current times the lowest product of two
        highestProductOf3 = max(highestProductOf3,
                                current * highestProductOf2,
                                current * lowestProductOf2)
        
        // do we have a new highest product of two?
        highestProductOf2 = max(highestProductOf2,
                                current * highest,
                                current * lowest)
        
        // do we have a new lowest product of two?
        lowestProductOf2 = min(lowestProductOf2,
                               current * highest,
                                current * lowest)
        
        // do we have a new highest?
        highest = max(highest, current)
        
        // do we have a new lowest?
        lowest = min(lowest, current)
    }
    
    return highestProductOf3
}


//: This is my solution, it keeps track of the three largest numbers which in turn will make the highes product of 3 and then multiplies them and returns the result.

func highestProductOfThree(numbers: [Int]) throws -> Int {
    
    guard numbers.count >= 3 else {
        throw HighestProductError.lessThanThree
    }
    
    var first = 0
    var second = 0
    var third = 0
    
    for number in numbers {
        if abs(number) >= abs(first) {
            third = second
            second = first
            first = number
        } else if abs(number) > abs(second) {
            third = second
            second = number
        } else if abs(number) > abs(third) {
            third = number
        }
    }
    
    return first * second * third
}

//: Test solution number 1
//do {
//    print(try highestProductOf3([1,2,3,4,5]))
//} catch {
//    print(error)
//}
//
//do {
//    print(try highestProductOf3([-10, -10, 1, 3 , 2]))
//} catch {
//    print(error)
//}
//
//do {
//    print(try highestProductOf3([]))
//} catch {
//    print(error)
//}

//: Test solution number 2
//do {
//    print(try highestProductOf3([4, 4, 4, 1, 3]))
//} catch {
//    print(error)
//}
//
//do {
//    print(try highestProductOf3([-10, -10, 1, 3 , 2]))
//} catch {
//    print(error)
//}
//
//do {
//    print(try highestProductOfThree(numbers: []))
//} catch {
//    print(error)
//}


/*:
 
 Product of all other numbers.
 
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

//: Test

//    print(try getProductsOfAllIntsExceptAtIndex([1, 7, 3, 4]))

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

//print(findDuplicates(array: [1, 2, 2, 3]))
//print(findDuplicates(array: []))


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

//print(removeDuplicates(numbers: testDuplicates))

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
//indexEqualsValueSearch(array: test)

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
//maxNonNegativeSubArray(array: a)


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

//findLargest(data: sample)
