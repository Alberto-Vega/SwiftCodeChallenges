import Foundation

public class TreeNode<T> {
    public var data:T?
    public var left: TreeNode?
    public var right: TreeNode?
    
    public init(data: T?) {
        guard let data = data else { return }
        self.data = data
    }
}

public class Node<T> {
    public var value:T?
    public var left: Node?
    public var right: Node?
    
    public init(value: T?) {
        guard let value = value else { return }
        self.value = value
    }
}
