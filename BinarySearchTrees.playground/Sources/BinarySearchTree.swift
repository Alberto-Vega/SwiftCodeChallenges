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
