//
//  KGBoidShapes.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// The default boid shape list.
/// Uses associated values to specifie values.
enum KGBoidShapes {
    
    /// Square shape.
    case square
    
    /// Triangle shape.
    case triangle
    
    /// Line shape.
    case line
    
    /// Circle shape.
    case circle
    
    /// Returns CGPath for chosen shape.
    ///
    /// - Parameters:
    ///     - length: The length of the chosen shape.
    func cgPathRepresentative(length: CGFloat) -> CGPath {
        switch self {
        case .square:
            let squareBezierPath = UIBezierPath()
            
            squareBezierPath.move(to: CGPoint(x: -length, y: -length / 2))
            squareBezierPath.addLine(to: CGPoint(x: -length, y: length / 2))
            squareBezierPath.addLine(to: CGPoint(x: 0, y: length / 2))
            squareBezierPath.addLine(to: CGPoint(x: 0, y: -length / 2))
            squareBezierPath.close()
            
            return squareBezierPath.cgPath
            
        case .triangle:
            let triangleBezierPath = UIBezierPath()
            
            triangleBezierPath.move(to: CGPoint(x: -length, y: -length / 2))
            triangleBezierPath.addLine(to: CGPoint(x: -length, y: length / 2))
            triangleBezierPath.addLine(to: CGPoint(x: 0, y: 0))
            triangleBezierPath.close()
            
            return triangleBezierPath.cgPath
            
        case .line:
            let lineBezierPath = UIBezierPath()
            
            lineBezierPath.move(to: CGPoint(x: -length, y: -1))
            lineBezierPath.addLine(to: CGPoint(x: -length, y: 1))
            lineBezierPath.addLine(to: CGPoint(x: 0, y: 1))
            lineBezierPath.addLine(to: CGPoint(x: 0, y: -1))
            lineBezierPath.close()
            
            return lineBezierPath.cgPath
            
        case .circle:
            let circleRect = CGRect.init(x: -length / 2, y: -length / 2, width: length, height: length)
            let circleBezierPath = UIBezierPath.init(ovalIn: circleRect)
            
            return circleBezierPath.cgPath
        }
    }
}
