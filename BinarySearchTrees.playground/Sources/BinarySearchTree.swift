import Foundation

public class BSTNode<T> {
    public var data:T?
    public var left: BSTNode?
    public var right: BSTNode?
    
    init?(data: T?, right: BSTNode?, left: BSTNode?) {
        guard let data = data, right = right, left = left else { return }
        self.data = data
        self .left = left
        self.right = right
    }
    
    public func getLeft()-> BSTNode? {
        guard let left = left else {return nil}
        return left
    }
    public func getRight()-> BSTNode? {
        guard let right = right else {return nil}
        return right
    }
    
}
