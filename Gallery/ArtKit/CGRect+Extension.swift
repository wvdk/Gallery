//
//  CGRect+Extension.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension CGRect {
    
    /// Returns a random point generated within the receivers frame.
    public var randomPoint: CGPoint {
        let xPosition = CGFloat.random(in: origin.x...origin.x + size.width)
        let YPosition = CGFloat.random(in: origin.y...origin.y + size.height)
        return CGPoint(x: xPosition, y: YPosition)
    }
    
    /// Returns a rect generated from specified two point.
    public static func make(_ point1: CGPoint, _ point2: CGPoint) -> CGRect {
        return CGRect(x: min(point1.x, point2.x),
                      y: min(point1.y, point2.y),
                      width: abs(point1.x - point2.x),
                      height: abs(point1.y - point2.y))
    }
}
