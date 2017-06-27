//: Playground - noun: a place where people can play

import UIKit

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


