//
//  ArrayExtensions.swift
//

import Foundation

extension Array {
    
    public func randomItem() -> Element {
        let randomIndex = Int.random(in: 0..<self.count)
        return self[randomIndex]
    }
    
}

extension Array where Element == CGPoint {
    
    /// Returns the average of all elements in the `CGPoint` array.
    public var average: CGPoint {
        let total = reduce(CGPoint.zero) { (result, element) -> CGPoint in
            return CGPoint(x: result.x + element.x, y: result.y + element.y)
        }
        
        return total.divide(by: CGFloat(count))
    }
}

extension Array where Element == CGVector {
    
    /// Returns the average of all elements in the `CGVector` array.
    public var average: CGVector {
        let total = reduce(CGVector.zero) { (result, element) -> CGVector in
            return CGVector(dx: result.dx + element.dx, dy: result.dy + element.dy)
        }
        
        return total.divide(by: CGFloat(count))
    }
}
