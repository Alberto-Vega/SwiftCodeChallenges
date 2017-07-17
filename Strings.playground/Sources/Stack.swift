import Foundation

public struct Stack<T> {
    var items = [T]()
    
    public mutating func push(item: T) {
        items.append(item)
    }
    public mutating func pop() -> T {
        return items.removeLast()
    }
    
    public mutating func peek() -> T? {
        return items.last
    }
    public var isEmpty: Bool {
        return items.isEmpty
    }
    public init(items:[T]) {
            self.items = items
    }
    
    public init() {
        self.items = [T]()
    }
}
