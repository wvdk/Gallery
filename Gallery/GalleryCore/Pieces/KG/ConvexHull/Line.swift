//
//  Line.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

struct Line {
    
    let startPoint: CGPoint
    let endPoint: CGPoint
    
    let uuid: String
    
    var cgPath: CGPath {
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        return path.cgPath
    }
    
    init(startPoint: CGPoint, endPoint: CGPoint) {
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.uuid = UUID().uuidString
    }
}
