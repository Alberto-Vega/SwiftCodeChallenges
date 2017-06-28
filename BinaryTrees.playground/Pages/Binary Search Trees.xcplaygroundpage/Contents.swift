
import UIKit
//: # Binary Search Tree.

/*:
 
 ## Search
 
One advantage of the binary search tree is that the lookup operation is fast and simple:
 
 O(log N) - time complexity in a balanced binary search tree.
 
 In the case that every node only has one child, the BST is unbalanced. In which case it is pretty much like a linked list and you will have to traverse all the nodes in the worst case scenario
 
    1
      \
        2
          \
            3
              \ 
                4
 
 lookup becomes
 O(N) - unbalanced binary search tree.
 
 */

//:  ### No Recursion.

func lookup(value: Int, root: TreeNode<Int>?) -> TreeNode<Int>? {
    var root = root
    while root != nil {
        guard let currentValue = root?.data else {
            break
        }
        if currentValue == value {
            break
        }
        if currentValue > value {
            root = root?.left
        } else {
            root = root?.right
        }
    }
    return root
}


//:  ### Recursive.

func search(value: Int, root: TreeNode<Int>?) -> TreeNode<Int>? {
    guard  let root = root else {
        return nil
    }
    
    guard let currentValue = root.data else {
        return nil
    }
    
    if value == currentValue {
        return root
    }
    
    if value < currentValue {
        return search(value: value, root: root.left)
    } else {
        return search(value: value, root: root.right)
    }
}

//: ###  lookup tests.
let testBST = TreeNode<Int>(data: 4)
// create left subtree
testBST.left = TreeNode<Int>(data: 3)
testBST.left?.left = TreeNode<Int>(data: 1)
testBST.left?.right = TreeNode<Int>(data: 2)
// create right subtree
testBST.right = TreeNode<Int>(data: 6)
testBST.right?.left = TreeNode<Int>(data: 5)
testBST.right?.right = TreeNode<Int>(data: 7)

if let result = search(value: 7, root: testBST)?.data {
    print(result)
}

if let result = lookup(value: 7, root: testBST)?.data {
    print(result)
}
/*:
 -----
  ## Traversals
  ## Depth First Traveral
 */
/*:
 ### In-Order Traversal
Visit the left node, then the current node, and finally, the right node.
 ### Recursive.
*/
func inOrderTraversal(root: TreeNode<Int>?) {
    guard let current = root else { return }
    inOrderTraversal(root: current.left)        // 1. print left
    print(current.data ?? "node data is nil")   // 2. print root
    inOrderTraversal(root: current.right)       // 3. print right
}
//: Iterative.
func inOrderTraversalIterative(root: TreeNode<Int>?) {
    guard var current = root else { return }
    var stack = Stack<TreeNode<Int>>()
    
    while current.left != nil {
        if current.right != nil {
            stack.push(item: current.right!)
        }
        stack.push(item: current)
        if current.left != nil {
            current = current.left!
        }
    }
    print(stack.length())
}
// while (stack.length() > 0) {
//// var node = stack.pop()
// 
//    
//}
 
    /*
 
      3
     / \
    2   4
   /
  1

 4 3 2 1
 
 
 
 */
 
/*:
 ### Pre-Order Traversal
 Visit the current node before its child nodes.
 */
func preOrderTraversal(root: TreeNode<Int>?) {
    guard let current = root else { return }
    print(current.data ?? "node data is nil")   // 1. print root
    preOrderTraversal(root: current.left)       // 2. print left
    preOrderTraversal(root: current.right)      // 3. print right
}
/*:
 ### Post-Order Traversal
 Visit the child nodes first and then current node.
 */
func postOrderTraversal(root: TreeNode<Int>?) {
    guard let current = root else { return }
    postOrderTraversal(root: current.left)      // 1. print left
    postOrderTraversal(root: current.right)     // 2. print right
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
//inOrderTraversal(root: inputBST)
//preOrderTraversal(root: inputBST)
//postOrderTraversal(root: inputBST)
inOrderTraversalIterative(root: inputBST)
/*:
 
 ## Breadth First Traveral
 
 ### Level Order Traversal.
 Start with the root, move left to right across the second level, then move left to right
 across the third level, and so forth. You continue the search until either you have 
 examined all the nodes or you find the node you are searching for.
  A BFS uses additional memory because it is necessary to track the child nodes for all
 nodes on a given level while searching that level.
*/
func levelOrderTraversal(root: TreeNode<Int>?) {
    guard let root = root else { return }
    var queue = Queue<TreeNode<Int>>()
    
    queue.enqueue(root)
    
    while !queue.isEmpty {
        guard let  current = queue.peek() else { return }
        print(current.data ?? "current node data is nil")
        if current.left != nil {
            queue.enqueue((current.left)!)
        }
        if current.right != nil {
            queue.enqueue((current.right)!)
        }
        queue.dequeue()
    }
}

//levelOrderTraversal(root: inputBST)

/*:
 ### 24. Given a sorted array, create a binary search tree with minimal height
 Don't get confused by the minimal height requirement. That is a characteristic of a binary search tree anyway.
 - Since the array is sorted just find the middle element and make it the tree root node.
 - Recursively do the same for the left and the right half of the array.
 - Every root found on the way will be assigned as a child node of the root created on the previous step.
 */

func createBSTFrom(array: Array<Int>, start: Int, end: Int) -> TreeNode<Int>? {
    guard start <= end else { return nil } // Base Case.
    // same as (start+end)/2, avoids overflow.
    let middleIndex = start + (end - start) / 2
    let node = TreeNode<Int>(data: array[middleIndex]) // Get middle element and make it the root node.
    node.left = createBSTFrom(array: array, start: start, end: middleIndex - 1)
    node.right = createBSTFrom(array: array, start: middleIndex + 1, end: end)
    
    return node
}

let BSTRoot = createBSTFrom(array: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], start: 0, end: 9)
inOrderTraversal(root: BSTRoot)
/*:
  The result looks like:
 
            5
          /   \
         2     8
        / \   /  \
       1   3  6  9
            \  \   \
            4   7   10
 */
//: ### 23. Determine if a binary tree is balanced
//: Check Balanced: Implement a function to check if a binary tree is balanced. For the purposes of this question, a balanced tree is defined to be a tree such that the heights of the two subtrees of any node never differ by more than one.

//func checkBalance(root: TreeNode<Int>?) -> Int {
////    guard let root = root else { return 0 }
//    
// 
//}

func checkHeight(root: TreeNode<Int>?) -> Int {
    guard let root = root else { return -1 }

    
    let leftHeight = checkHeight(root: root.left)
    if leftHeight == Int.min  {
        return Int.min
    }
    
    let rightHeight = checkHeight(root: root.right)
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
//: ### Level by level printing of a Binary Search Tree.
/*:
 This solution uses two queues. The time complexity is O(n) since it visits every node in the tree. Space complexity is O(n) worst case scenario.
Explanation of this algorithm ca be found here Video link - https://youtu.be/7uG0gLDbhsI
*/

func printLevelByLevelTree(root: TreeNode<Int>?) {
    guard let root = root else { return }
    var queueOne = Queue<TreeNode<Int>>()
    var queueTwo = Queue<TreeNode<Int>>()
    
    queueOne.enqueue(root)
    while !queueOne.isEmpty || !queueTwo.isEmpty {
        while !queueOne.isEmpty {
            guard let root = queueOne.dequeue() else { return }
            print(root.data ?? "failed to get TreeNode data", terminator: " ")
            if let rootLeft = root.left {
                queueTwo.enqueue(rootLeft)
            }
            if let rootRight = root.right {
                queueTwo.enqueue(rootRight)
            }
        }
        print("")
        while !queueTwo.isEmpty { // queue two is not empty.
            guard let root = queueTwo.dequeue() else { return }
            print(root.data ?? "failed to get TreeNode data", terminator: " ")
            if let rootLeft = root.left {
                queueOne.enqueue(rootLeft)
            }
            if let rootRight = root.right {
                queueOne.enqueue(rootRight)
            }
        }
        print("")
    }
}

//printLevelByLevelTree(root: inputBST)

//: ### Given a binary tree create a linked list of all the nodes at each depth.
func createLevelLinkedList(root: TreeNode<Int>?, lists: inout Array<LinkedList<TreeNode<Int>>>, level: Int) {
    var lists = lists
    guard let root = root else { return } // Base case if root is nil return.
    var list = LinkedList<TreeNode<Int>>()
    if lists.count == level { // Level not contained in the list.
        list = LinkedList<TreeNode<Int>>()
        lists.append(list)
    } else {
        list = lists[level]
    }
    
    list.append(root)
    createLevelLinkedList(root: root.left, lists: &lists, level: level + 1)
    createLevelLinkedList(root: root.right, lists: &lists, level: level + 1)

}

func createLevelLinkedList(root: TreeNode<Int>) -> Array<LinkedList<TreeNode<Int>>> {
    var lists = Array<LinkedList<TreeNode<Int>>>()
    createLevelLinkedList(root: root, lists: &lists, level: 0)
    return lists
}

////let list = createLevelLinkedList(root: inputBST)
//
//for item in list {
//    var current = item.first
//    while current != nil {
//        print(current?.value?.data ?? "failed to get treenode data")
//        current = current?.next
//    }
//}

/*
 void createLevelLinkedList(TreeNode root, ArrayList<LinkedList<TreeNode>> l i s t s , in t le v e l) {
 if (root == null) return; // base case
 LinkedList<TreeNode> l i s t = n u ll;
 if (lists.size() == level) { // Level not contained in list
 list = new LinkedList<TreeNode>();
 /* Levels are always traversed in order. So, if this is the
 * first time we've visited level i, we must have seen levels * 0 through i - 1. We can therefore safely add the level at * the end. */
 lists.add(list); }else{
 list = lists.get(level); }
 list.add(root);
 createLevelLinkedList(root.left, lists, level + 1); createLevelLinkedList(root.right, lists, level + 1);
 }
 ArrayList<LinkedList<TreeNode>> createLevelLinkedList( TreeNode root) {
 ArrayList<LinkedList<TreeNode>> lists = new ArrayList<LinkedList<TreeNode>>();
 createLevelLinkedList(root, lists, 0);
 return lists; }
 */
