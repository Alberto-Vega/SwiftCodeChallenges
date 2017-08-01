import Foundation

public class LinkedListNode <Element: Equatable> {
    public var data: Element?
    public var next: LinkedListNode?
    
    public init(data: Element) {
        self.data =  data
    }
}



extension LinkedListNode: Equatable {
    public static func ==(lhs: LinkedListNode, rhs: LinkedListNode) -> Bool {
        return lhs.data == rhs.data && lhs.next == lhs.next
    }
}



public class LinkedList <Element: Equatable> {
    public var root: LinkedListNode<Element>?
    public var tail: LinkedListNode<Element>?
    public init(root: LinkedListNode<Element>) {
        self.root = root
        self.tail = root
    }
    
    public func append(data: Element) {
        let newNode = LinkedListNode(data: data)
        var tempNode = self.root
        while tempNode?.next != nil {
            tempNode = tempNode?.next
        }
        tempNode?.next = newNode
        tail = newNode
    }
    
    public func printNodeValues() {
        var temp = self.root
        while temp != nil {
            print(temp?.data ?? "Node data not available")
            temp = temp?.next
        }
    }
}

