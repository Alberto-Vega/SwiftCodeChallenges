import Foundation

public class LinkedListNode <Element> {
    public var data: Element?
    public var next: LinkedListNode?
    
    init(data: Element) {
        self.data =  data
    }
}