//
//  KGDeStijlController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGDeStijlController {
    
    // MARK: - Properties
    
    // MARK: - Initialization
    
    @discardableResult func setup(pointCount: Int, in rect: CGRect) -> [KGLineDrawingAction] {
        var points = [CGPoint]()
        
        for _ in 1...pointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            points.append(newPoint)
        }
        
        let tree = KGKDimensionTree(maxDimension: 2, from: points)
        let actions = tree.actionBuffer.map { return KGLineDrawingAction(line: $0.node.line(in: rect), type: .addition, index: $0.index) }
        return actions
    }
}
