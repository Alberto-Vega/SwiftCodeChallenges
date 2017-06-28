//: [Previous](@previous)

import Foundation

func heapifyBinaryTree(root: Node<Int>) -> Node<Int>? {
    var nodeArray: [Node<Int>?]?
    let size = traverse(node: root, count: 0, array: &nodeArray)
    nodeArray = [Node<Int>?](repeating: nil, count: size)
    traverse(node: root, count: 0, array: &nodeArray)
    
    nodeArray?.sort(by: { (a: Node<Int>?, b: Node<Int>?) -> Bool in
        guard let aValue = a?.value, let bValue = b?.value else  { return false }
        return aValue < bValue
    })
    
    buildTreeFromArray(array: &nodeArray)
    
    return nodeArray?[0]
}

func traverse(node: Node<Int>?, count: Int, array: inout [Node<Int>?]?) -> Int {
    guard let node = node else { return count }
    array?[count] = node
    var count = count
    count += 1
    count = traverse(node: node.left, count: count, array: &array)
    count = traverse(node: node.right, count: count, array: &array)
    
    return count
}

func buildTreeFromArray(array: inout [Node<Int>?]?) {
    guard let size = array?.count else { return }
    for i in 0..<size {
        let left = 2*i + 1
        let right = left + 1
        array?[i]?.left = left >= size ? nil : array?[left]
        array?[i]?.right = right >= size ? nil : array?[right]
    }
}



//: ###  Traversals tests.
let inputBST = Node<Int>(value: 3)
inputBST.left = Node<Int>(value: 2)
inputBST.right = Node<Int>(value: 4)
inputBST.left?.left = Node<Int>(value: 1)

/*:
 This binary search tree looks like:
 
 3
 / \
 2   4
 /
 1
 
 */

heapifyBinaryTree(root: inputBST)


//: [Next](@next)
