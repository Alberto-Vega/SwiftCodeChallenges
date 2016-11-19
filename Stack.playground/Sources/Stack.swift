import Foundation

public struct Stack<T> {
    var items = [T]()
    public mutating func push(item: T) {
        items.append(item)
    }
    public mutating func pop() -> T {
        return items.removeLast()
    }
    
    public var isEmpty: Bool {
        return items.isEmpty
    }
    
    public init() {
    }
    
    public init(items:[T]) {
            self.items = items
    }
}
