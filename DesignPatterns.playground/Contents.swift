//: Playground - noun: a place where people can play

import UIKit

/*:
#Design Patterns Problems


 1. Your application uses a logging class to write debugging messages to the console. How would you implement this logging facility using the Singleton pattern?

 Follow up:
 2. Your application uses a singleton, but it's not always necessary, and it's expensive to initialize. How can you improve this situation?
 
 The solution is using deferred initialization also called lazy initialization or lazy loading.
 
 
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
