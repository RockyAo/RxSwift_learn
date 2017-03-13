import Foundation

import Foundation

public func exampleOf(description:String, action:  @escaping ()->Void)  {
    
    print("\n------exampleOf:\(description)------")
    
    action()
    
}

import PlaygroundSupport

public func playgroundShouldContinueIndefinitely() {
    PlaygroundPage.current.needsIndefiniteExecution = true
}
