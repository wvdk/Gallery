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
}
