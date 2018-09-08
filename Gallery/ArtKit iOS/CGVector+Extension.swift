//
//  CGVector+Extension.swift
//  ArtKit iOS
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension CGVector {
    
    /// Returns vector distnace.
    public var length: CGFloat {
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }

    /// Returns angle in radians.
    public var angleToNormal: CGFloat {
        let angle = atan2(dy, dx)
        return CGFloat(angle)
    }
    
    /// Returns normalized CGVector.
    public var normalized: CGVector {
        let maxComponent = max(abs(dx), abs(dy))
        return self.divide(by: maxComponent)
    }
    
    /// Returns CGVector divided by specified value.
    public func divide(by value: CGFloat) -> CGVector {
        return CGVector(dx: dx / value, dy: dy / value)
    }
    
    /// Returns CGVector multiplied by specified value.
    public func multiply(by value: CGFloat) -> CGVector {
        return CGVector(dx: dx * value, dy: dy * value)
    }
    
    /// Returns CGVector added to specified value.
    public func add(_ value: CGVector) -> CGVector {
        return CGVector(dx: dx + value.dx, dy: dy + value.dy)
    }
    
    /// Returns random vector from the range.
    public static func random(min: CGFloat, max: CGFloat) -> CGVector {
        let x = CGFloat.random(min: min, max: max)
        let y = CGFloat.random(min: min, max: max)
        
        return CGVector(dx: x, dy: y)
    }
}
