
import UIKit

/*:
 Remove a node from a linked list.
 
 Clarify the question:
 
 Is this a single or doubly linked list? Do we have a reference to the root?
 In this case we can assume that is a single linked list and we only have a reference to the node to delete.
 
 Brainstorming:
 
 If we had a reference to the root node we could:
 
 Stack or recursion:
 
 O(N) - time
 O(N) - space
 
 Using two variables in 3 passes or even one pass to redirect the next references of the nodes.
 
 O(N) - time
 O(1) - space
 
 We cannot use any of the previous solutions since we cant get access to the previous node by traversing the linked list. This is a consecuence of not having a reference to the root of the tree.
 
 Copying the next node value and next reference to current then set current to nil
 
 O(1) - time
 O(1) - space

 pros: great time and space complexity
 cons: It can lead to bugs due to code having references to the node we just
 changed it's values. Also it doesn't work when the nodeToDelete is the last one.
 
 Input
 
 (1)-> nil
 
 delete (1)
 
 Output
 
 throw an error since list is just 1 node or maybe return nil depending of how
 the interviewer wants you to handle it.
 
 Input
 
 (1)->(2)-> nil
 
 delete (1)
 
 Output
 
 (2)-> nil
 
 Input
 
 (1)->(2)->(3)->(4)-> nil
 
 delete (3)
 
 Output
 
 (1)->(2)->(4)-> nil
 
 Input
 
 list
 (1)->(2)-> nil
 
 delete (2)
 
 Output
 
 (1)-> nil
 
 
 Using two variables in even one pass to redirect the next pointers in the nodes.
 
 */

enum DeleteNodeError: Error, CustomStringConvertible {
    case lessThanTwoNodes
    
    var description: String {
        switch self {
        case .lessThanTwoNodes:
            return "Unable to delete node. List only has one node"
        }
    }
}

func deleteNode<T>(node: LinkedListNode<T>, fromList root: LinkedListNode<T>) throws {
    var previous: LinkedListNode<T>? = nil, next: LinkedListNode<T>? = nil, current: LinkedListNode<T> = root
    
    while current !== node {
        if let nextNode = current.next {
            previous = current
            current = nextNode
            if let secondNext = nextNode.next {
                next = secondNext
            }
        }
    }
    previous?.next = next
    current.next = nil
}

let a = LinkedListNode(data: "A")
let b = LinkedListNode(data: "B")
let c = LinkedListNode(data: "C")

let list = LinkedList(root: a)

a.next = b
b.next = c


if let listRoot = list.root {
    try deleteNode(node: b, fromList: listRoot)
    list.printNodeValues()
}

//:  Using two variables in 3 passes or even one pass.

enum DeleteNodeError2: Error, CustomStringConvertible {
    case lastNode
    
    var description: String {
        return "Can't delete the last node with this method!'"
    }
}

func deleteNode<T: Equatable>(_ nodeToDelete: LinkedListNode<T>) throws {
    //get the input node's next node, the one we want to skip to
    guard let nextNode = nodeToDelete.next else {
        throw DeleteNodeError2.lastNode
    }
    
    // replace the input node's value and pointer with the next
    // node's value and pointer.
    nodeToDelete.data = nextNode.data
    nodeToDelete.next = nextNode.next
    nextNode.next = nil
    
}


/*:
 Return Kth to last node in a linked list.
 
 Brainstorming:
 
 Use a stack or recursion.
 
 O(N) - time
 O(N) - space
 
 Use two runners separated by Kth
 
 O(N) - time
 O(1) - space
 
 These two cases have the same complexity.
 Solution 1 Count the nodes in one pass to get the lenght and then find the node at (lenght - K)
 Solution 2 Check the lenght (N) in one pass and then return the node at N - K

 O(N) - time
 O(1) - space
 
 However, the second approach might still be slightly faster, due to some caching and other optimizations that modern processors and memory have.
 
 Input cases:
 
 Input                                          Output
 
 
 K = 2     1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7          5
 
 k = 5     1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7          2
 
 k = 6     1 -> 2 -> 3 -> 4 -> 5                    2
 
 k = 0     1 -> 2 -> 3 -> 4 -> 5                    nil


 
 Solution 2:
 */

enum KthError: Error, CustomStringConvertible {
    case lessThanFirst(Int)
    case largerThanLength(Int)
    
    var description: String {
        if case .lessThanFirst(let k) = self {
            return "Impossible to find less than first to last node: \(k)"
        
        }
        
        if case .largerThanLength(let k) = self {
            return "k is larger than the length of the linked list: \(k)"
        }
        
        return ""
    }
}

func findKthFromLast<T>(root: LinkedListNode<T>, k: Int) throws -> LinkedListNode<T>? {
    guard k >= 1 else {
        throw KthError.lessThanFirst(k)
    }
    
    var firstNode = root
    var secondNode = root
    
    for _ in 0..<(k-1) {
        if let next = secondNode.next {
        secondNode = next
        } else {
            throw KthError.largerThanLength(k)
        }
    }
    
    while let  secondNext = secondNode.next, let firstNext = firstNode.next {
        secondNode = secondNext
        firstNode = firstNext
    }
    
    return firstNode
}

//: Tests

//let root4 = LinkedListNode(data: 1)
//let linkedListTest4 = LinkedList(root: root4)
//linkedListTest4.append(data: 2)
//linkedListTest4.append(data: 3)
//linkedListTest4.append(data: 4)
//linkedListTest4.append(data: 5)
//linkedListTest4.append(data: 6)
//linkedListTest4.append(data: 7)
//
//let secondFromLastNode = try findKthFromLast(root: linkedListTest4.root!, k: 2)
//print(secondFromLastNode?.data ?? "Unable to print node")


/*:
 You have a linked list and want to reverse it.
 
 Brainstorming:
 
 Use a stack or recursion.
 
 O(N) - time
 O(N) - space
 
 Use two runners
 
 O(N) - time
 O(1) - space
 
 Input cases:
 
 Input
 
 
  1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7
 
 Output

  1 <- 2 <- 3 <- 4 <- 5 <- 6 <- 7
 
 Input
 
  5
 
 Output
 
  5

 Input
  
  nil
 
 Output
 
  nil

 */

func reverseList<T>(root: LinkedListNode<T>?) -> LinkedListNode<T>? {
    var previous:LinkedListNode<T>? = nil
    var current = root
    var next = root?.next
    
    while current != nil {
        current?.next = previous
        previous = current
        current = next
        next = current?.next
    }
    return previous
}

//: Tests

//let root1 = LinkedListNode(data: 1)
//let linkedListTest3 = LinkedList(root: root1)
//linkedListTest3.append(data: 2)
//linkedListTest3.append(data: 3)
//linkedListTest3.append(data: 4)
//linkedListTest3.append(data: 5)
//linkedListTest3.append(data: 6)
//linkedListTest3.append(data: 7)
//
//
////linkedListTest3.root = reverseList(root: linkedListTest3.root)
////
////linkedListTest3.printNodeValues()

//let root3 = LinkedListNode(data: 5)
//let oneNodeLinkedList = LinkedList(root: root3)
//oneNodeLinkedList.root = reverseList(root: oneNodeLinkedList.root)
//oneNodeLinkedList.printNodeValues()


/*:
 You have a linked list and want to check if it has a cycle
 
 Brainstorming:

   Use a hash.
 
 O(N) - time
 O(N) - space
 
    Use two runners
 
 O(N) - time
 O(1) - space
 
 
 */

func hasLoop<T>(root: LinkedListNode<T>?) -> Bool {
    
    if root == nil {
        return false
    }
    
    var slowRunner = root
    var fastRunner = root
    
    while fastRunner != nil  {
        
        slowRunner = slowRunner?.next
        fastRunner = fastRunner?.next?.next
        
        if fastRunner === slowRunner {
            return true
        }
    }
    return false
}

/*:
 Test:
 */
let root = LinkedListNode(data: 1)
let linkedListTest1 = LinkedList(root: root)
linkedListTest1.append(data: 2)
linkedListTest1.append(data: 3)
linkedListTest1.append(data: 4)
linkedListTest1.append(data: 5)
linkedListTest1.append(data: 6)
linkedListTest1.append(data: 7)


//: We create a loop by setting the last element next pointer to root:
//linkedList.tail?.next = root
//print(hasLoop(root: linkedListTest1.root))



let root2 = LinkedListNode(data: 1)
let linkedListTest2 = LinkedList(root: root2)
var currentNode = linkedListTest2.root
for data in 2...7 {
    let newNode = LinkedListNode(data: data)
    currentNode?.next = newNode
    if let next = currentNode?.next {
        currentNode = next
    }
}

var current = linkedListTest2.root

while current?.data != 7 {
    current = current?.next
}

var cycleStart = linkedListTest2.root

while cycleStart?.data != 3 {
    cycleStart = cycleStart?.next
}

current?.next = cycleStart


//hasLoop(root: linkedListTest2.root)




//: 15. Write code to remove duplicates from an unsorted linked list. Follow up: How would you solve it if temporary buffer is not allowed?

//: Using a temporary buffer.

func deleteDuplicates(n: LinkedListNode<Int>?) {
    var n = n
    var set = Set<Int>()
    var previous: LinkedListNode<Int>?
    while(n != nil) {
        if(set.contains(n!.data!)) {
            previous?.next = n?.next
        } else {
            set.insert((n?.data)!)
            previous = n
        }
        n = n?.next
    }
}

//: Uncomment the following code to test.
//var dupNode = LinkedListNode(data: 0)
//var dupNode1 = LinkedListNode(data: 1)
//var dupNode2 = LinkedListNode(data: 1)
//var dupNode3 = LinkedListNode(data: 2)
//
//dupNode.next = dupNode1
//dupNode1.next = dupNode2
//dupNode2.next = dupNode3

//printNodes(dupNode)
//
////deleteDuplicates(dupNode)
//
//printNodes(dupNode)

//: - Follow up: No Buffer Allowed.

func deleteDuplicatesNoBuffer(head: LinkedListNode<Int>?) {
    var current = head
    while current != nil {
        //Remove all future nodes that have the same value.
        var runner = current
        while runner?.next != nil {
            if runner?.next?.data == current?.data {
                runner?.next = runner?.next?.next
            } else {
                runner = runner?.next
            }
        }
        current = current?.next
    }
}

//: Uncomment the following code to test.

//var dupNode = LinkedListNode(data: 0)
//var dupNode1 = LinkedListNode(data: 1)
//var dupNode2 = LinkedListNode(data: 1)
//var dupNode3 = LinkedListNode(data: 2)
//
//dupNode.next = dupNode1
//dupNode1.next = dupNode2
//dupNode2.next = dupNode3
//
//printNodes(dupNode)
//
//deleteDuplicatesNoBuffer(dupNode)
//
//printNodes(dupNode)

//: 19. Reverse a linked list – iteratively and recursively
//: Iterative approach.

func reverse(head:LinkedListNode<Int>?)-> LinkedListNode<Int>? {
    var head = head
    var current = head, previous:LinkedListNode<Int>?, next: LinkedListNode<Int>?
    while(current != nil) {
        next = current?.next
        current?.next = previous
        previous = current
        current = next
    }
    
    head = previous
    guard let newHead = head else { return nil }
    return newHead
}

//: Recursive Approach.


