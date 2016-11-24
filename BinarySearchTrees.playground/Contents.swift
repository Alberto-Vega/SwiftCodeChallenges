
import UIKit
//: # Binary Search Tree.

/*:
 -----
  ## Traversals
 */
/*:
 ### In-Order Traversal
In-order traversal means to "visit" (often, print) the left node, then the current node, and finally, the right node.
*/
func inOrderTraversal(node: TreeNode<Int>?) {
    guard let current = node else { return }
    inOrderTraversal(node: current.left)        // 1. print left
    print(current.data ?? "node data is nil")   // 2. print root
    inOrderTraversal(node: current.right)       // 3. print right
}
/*:
 ### Pre-Order Traversal
 Pre-order traversal visits the current node before its child nodes.
 */
func preOrderTraversal(node: TreeNode<Int>?) {
    guard let current = node else { return }
    print(current.data ?? "node data is nil") // 1. print root
    preOrderTraversal(node: current.left)     // 2. print left
    preOrderTraversal(node: current.right)    // 3. print right
}
/*:
 ### Post-Order Traversal
 Post-order traversal visits the child nodes first and then current node.
 */
func postOrderTraversal(node: TreeNode<Int>?) {
    guard let current = node else { return }
    postOrderTraversal(node: current.left)      // 1. print left
    postOrderTraversal(node: current.right)     // 2. print right
    print(current.data ?? "node data is nil")   // 3. print current
}
//: ###  Traversals tests.
let inputBST = TreeNode<Int>(data: 3)
inputBST.left = TreeNode<Int>(data: 2)
inputBST.right = TreeNode<Int>(data: 4)
inputBST.left?.left = TreeNode<Int>(data: 1)
/*:
 This binary search tree looks like:
 
        3
       / \
      2   4
     /
    1
 */
inOrderTraversal(node: inputBST)
preOrderTraversal(node: inputBST)
postOrderTraversal(node: inputBST)

/*: 
 ### 24. Given a sorted array, create a binary search tree with minimal height
 Don't get confused by the minimal height requirement. That is a characteristic of a binary search tree anyway.
 - Since the array is sorted just find the middle element and make it the tree root node.
 - Recursively do the same for the left and the right half of the array.
        - Every root found on the way will be assigned as a child node of the root created on the previous step.
 */
func createBSTFrom(array: Array<Int>, start: Int, end: Int) -> TreeNode<Int>? {
    guard !(start > end) else { return nil } // Base Case.
    let middleIndex = (start + end) / 2
    let node = TreeNode<Int>(data: array[middleIndex]) // Get middle element and make it the root node.
    node.left = createBSTFrom(array: array, start: start, end: middleIndex - 1)
    node.right = createBSTFrom(array: array, start: middleIndex + 1, end: end)
    
    return node
}

let BSTRoot = createBSTFrom(array: [1, 2, 3, 4], start: 0, end: 3)
inOrderTraversal(node: BSTRoot)

//: ### 23. Determine if a binary tree is balanced
//: Check Balanced: Implement a function to check if a binary tree is balanced. For the purposes of this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any node never differ by more than one.


func checkHeight(root: TreeNode<Int>?) -> Int {
    if root == nil {
        return -1
    }
    
    let leftHeight = checkHeight(root: root?.left ?? nil)
    if leftHeight == Int.min  {
        return Int.min
    }
    
    let rightHeight = checkHeight(root: root?.right ?? nil)
    if rightHeight == Int.min  {
        return Int.min
    }
    
    let heightDifference = leftHeight - rightHeight
    if abs(heightDifference) > 1 {
        return Int.min
    } else {
        return max(leftHeight, rightHeight) + 1
    }
}

func isBalanced(root: TreeNode<Int>) -> Bool {
    return checkHeight(root: root) != Int.min
}


//: ### isBalanced Test.

let unbalancedTree = TreeNode<Int>(data: 3)
unbalancedTree.left = TreeNode<Int>(data: 2)
unbalancedTree.right = TreeNode<Int>(data: 4)
unbalancedTree.left?.left = TreeNode<Int>(data: 1)
unbalancedTree.left?.left?.left = TreeNode<Int>(data: 0)
/*:
 This binary search tree looks like:
 
        3
       / \
      2   4
     /
    1
   /
  0
 */

if let balancedBST = createBSTFrom(array: [0, 1, 2, 3, 5, 6, 7, 8, 9, 10], start: 0, end: 9) {
    isBalanced(root: balancedBST)
}

isBalanced(root: unbalancedTree)
