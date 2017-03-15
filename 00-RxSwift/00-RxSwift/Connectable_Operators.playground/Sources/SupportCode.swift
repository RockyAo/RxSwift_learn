import Foundation

public func printExampleHeader(_ description: String) {
    print("\n--- \(description) example ---")
}

public func delay(_ delay: Double, closure: @escaping () -> Void) {
    
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}
