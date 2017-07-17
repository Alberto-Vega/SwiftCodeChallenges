//: [Previous](@previous)

/*:
 
 I'm making a search engine called MillionGazillion™
 
 I wrote a crawler that visits web pages, stores a few keywords in a database, and follows links to other web pages. I noticed that my crawler was wasting a lot of time visiting the same pages over and over, so I made a set, visited, where I'm storing URLs I've already visited. Now the crawler only visits a URL if it hasn't already been visited.
 
 Thing is, the crawler is running on my old desktop computer in my parents' basement (where I totally don't live anymore), and it keeps running out of memory because visited is getting so huge.
 
 How can I trim down the amount of space taken up by visited?
 
 *source https://www.interviewcake.com/question/swift/compress-url-list
 
 */


import Foundation

class TrieNode {
    
    private var nodeChildren: [Character: TrieNode] = [:]
    
    func hasChildNode(for character: Character) -> Bool {
        return nodeChildren[character] != nil
    }
    
    func makeChildNode(for character: Character) {
        nodeChildren[character] = TrieNode()
    }
    
    func getChildNode(for character: Character) -> TrieNode? {
        return nodeChildren[character]
    }
}

class Trie {
    
    private let rootNode = TrieNode()
    private var endOfWordMaker: Character = "\0"
    
    func checkPresentAndAdd(word: String) -> Bool {
        var currentNode = rootNode
        var isNewWord = false
        
        
        for character in word.characters {
            if !currentNode.hasChildNode(for: character) {
                isNewWord = true
                currentNode.makeChildNode(for: character)
            }
            
            if let childNode = currentNode.getChildNode(for: character) {
                currentNode = childNode
            }
        }
        // Explicitely mark the end of a word.
        // Otherwise, we might say a word is
        // present if it is a prefix of a different,
        // longer word what was added earlier.
        if !currentNode.hasChildNode(for: endOfWordMaker) {
            isNewWord = true
            currentNode.makeChildNode(for: endOfWordMaker)
        }
        return isNewWord
    }
    
}

//: Tests

var trie = Trie()
print(trie.checkPresentAndAdd(word: "dog.com"))
//print(trie.checkPresentAndAdd(word: "dog.com"))


//: [Next](@next)
