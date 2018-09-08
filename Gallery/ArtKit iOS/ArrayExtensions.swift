//
//  ArrayExtensions.swift
//

import Foundation

extension Array {
    
    public func randomItem() -> Element {
        let randomIndex = Int(arc4random_uniform(UInt32(self.count)))
        return self[randomIndex]
    }
    
}

extension Array {
    
    /// Returns the average `CGVector` of all elements in the array.
    public var averageForCGVectors: CGVector {
        let total = reduce(CGVector.zero) { (result, element) -> CGVector in
            guard let element = element as? CGVector else { return .zero }
            return CGVector(dx: result.dx + element.dx, dy: result.dy + element.dy)
        }
        
        return total.divide(by: CGFloat(count))
    }
    
    /// Returns the average `CGPoint` of all elements in the array.
    public var averageForCGPoint: CGPoint {
        let total = reduce(CGPoint.zero) { (result, element) -> CGPoint in
            guard let element = element as? CGPoint else { return .zero }
            return CGPoint(x: result.x + element.x, y: result.y + element.y)
        }
        
        return total.divide(by: CGFloat(count))
    }
}
