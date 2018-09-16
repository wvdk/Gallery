//
//  CGPoint+Extension.swift
//  ArtKit iOS
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension CGPoint {
    
    /// Returns distance between two points.
    public func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
    
    /// Returns CGVector to the specified point.
    public func vector(to point: CGPoint) -> CGVector {
        return CGVector(dx: point.x - x, dy: point.y - y)
    }
    
    /// Returns CGPoint divided by specified value.
    func divide(by value: CGFloat) -> CGPoint {
        return CGPoint(x: x / value, y: y / value)
    }
}
