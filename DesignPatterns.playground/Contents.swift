//: Playground - noun: a place where people can play

import UIKit

/*:
# Design Patterns
 
## Creational Patterns
 
 Manage class selection and object creation. You can delegate or restrict creation and access of object instances.
 
 ### Singleton:
 Only one instance used for shared resources or as a central communications hub.
        cons: Have to synchronize the methods for multithreading environments. It could slow down application startup time. It may hold to resources longer than necessary.
 ### Builder:
 Creates objects in your behalf in a stepwise manner without knowing or caring how those objects are constructed. Use them when objects are complex to construct and are constructed in several steps.
 ### Factory Method:
 Method whose primary purpose is to create and return a new object. In a class hierarchy base class defines the method that is then overriden by it's subclasses.
 ### Abstract Factory:
 It is an object that can create other objects. Separates the factory implementation from code that uses the factory

## Behavioral Patterns
 
 Determine how classes and objects interact and communicate.
 
 ### Iterator:
 Enables you to traverse through all the elements in a data structure without knowing or caring how those elements are stored or represented.
 ### Observer:
 It's also called "Publish - Subscribe" pattern. Allows objects to broadcast changes in state to interested observers without needing to know much about the observer.
 
## Structural Patterns
 Organize relationships between classes and objects, providing guidelines for combining and using related objects together to achieve desired behaviours.
 ### Decorator:
 Also called a "Wrapper". Modifies behaviour of an object by wrapping it with another object that implements the same interface as the original object. It's an alternative to subclassing. Decorator has 4 kinds of classes:
**Component**
    its an abstract class or interface that defines the interface shared by "Concrete Component" and "Decorator"
**Concrete Component** It's the class we want to modify.
**Decorator** It's an abstract class that that wraps the "Concrete Component" (the class we want to modify), and forwards all the method calls to the Component.
**Concrete Decorators** Of which they are tipically several, modify the behaviour of the wrapped "Concrete Component" by overriding one or more methods of their parent Decorator class. The overriden method tipically provides some additional functionality before and or after calling the corresponding method on the underlying "Concrete Component"
 
 Source:
 
 http://www.wrox.com/WileyCDA/WroxTitle/Programming-Interviews-Exposed-Secrets-to-Landing-Your-Next-Job-3rd-Edition.productCd-1118261364.html
 
 
 
 ### Design Patterns Problems


 1. Your application uses a logging class to write debugging messages to the console. How would you implement this logging facility using the Singleton pattern?

 Follow up:
 2. Your application uses a singleton, but it's not always necessary, and it's expensive to initialize. How can you improve this situation?
 
 The solution is to use deferred initialization also called lazy initialization or lazy loading. This will speed up startup time. With the cost of a delay caused by initialization the first time the shared instance is accessed. If the singleton is never used it won't be initialized saving time and resources. Unlike the case when it has to be initilized by the classloader (Java).
 
 */

class Logger {
    // The lazy initializer for the static variable (also for static members of structs and enums) is run the first time that global is accessed, and is launched as `dispatch_once` to make sure that the initialization is atomic.
    // source: https://krakendev.io/blog/the-right-way-to-write-a-singleton
    static let sharedInstance = Logger()
    private init() {} //This prevents others from using the default '()' initializer for this class.
    
    func log(message: String) {
        print("\(Date()) \(message)")
    }
}

//: Testing code

//Logger.sharedInstance.log(message: "this is a test")

/*:
 3. Why would you use the Decorator instead of inheritance.
 
 
 */
