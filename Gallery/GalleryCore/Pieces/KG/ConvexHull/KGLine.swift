//
//  KGLine.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

struct KGLine {
    
    let startPoint: CGPoint
    let endPoint: CGPoint
    
    let uuid: String
    
    var cgPath: CGPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path.cgPath
    }
    
    var curvedCGPath: CGPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        
        var firstControlPoint = startPoint
        firstControlPoint.x += CGFloat.random(in: -100...100)
        firstControlPoint.y += CGFloat.random(in: -100...100)

        var secondControlPoint = endPoint
        secondControlPoint.x += CGFloat.random(in: -100...100)
        secondControlPoint.y += CGFloat.random(in: -100...100)
        
        path.addCurve(to: endPoint, controlPoint1: firstControlPoint, controlPoint2: secondControlPoint)
        return path.cgPath
    }
    
    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.uuid = UUID().uuidString
    }
    
    func intersectionPoint(with line: KGLine) -> CGPoint? {
        let x1 = startPoint.x
        let y1 = startPoint.y
        
        let x2 = endPoint.x
        let y2 = endPoint.y
        
        let x3 = line.startPoint.x
        let y3 = line.startPoint.y
        
        let x4 = line.endPoint.x
        let y4 = line.endPoint.y
        
        // Common denominator.
        let da = (y4 - y3) * (x2 - x1)
        let db = (x4 - x3) * (y2 - y1)
        let denom = da - db
        
        guard denom != 0 else {
            NSLog("Parallel line segment or coincident.")
            return nil
        }
        
        // Numerators
        var ux = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)
        var uy = (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)
        
        ux = ux / denom
        uy = uy / denom
        
        // Line segment intersections are between 0 and 1. Both must be true; special care must be paid to both boundaries w/ floating point issues.
        if ux >= 0, (ux - 1) <= 0, uy >= 0, (uy - 1) <= 0 {
            let ix = x1 + ux * (x2 - x1)
            let iy = y1 + ux * (y2 - y1)
            
            return CGPoint(x: ix, y: iy)
        }
        
        // No intersection
        return nil
    }
}
