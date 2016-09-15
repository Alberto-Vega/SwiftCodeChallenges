//: Playground - noun: a place where people can play

import UIKit

// Depth First traversal.

func inOrderTraversal(root: BSTNode<Int>?) {
    guard let current = root else { return }
    print(current)
    inOrderTraversal(current.left)
    inOrderTraversal(current.right)

}