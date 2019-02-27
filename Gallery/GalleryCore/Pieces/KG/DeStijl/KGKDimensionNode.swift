//
//  KGKDimensionNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGKDimensionNode {
    
    private(set) var point: CGPoint
    private(set) var left: KGKDimensionNode?
    private(set) var right: KGKDimensionNode?
    private(set) var parent: KGKDimensionNode?
    
    private(set) var dimension: Int
    
    private var startPoint: CGPoint
    private var endPoint: CGPoint
    
    private var coordinate: CGFloat {
        switch dimension {
        case 1:
            return point.x
        default:
            return point.y
        }
    }
    
    var lineMinPoint: CGPoint {
        switch dimension {
        case 1:
            if startPoint.y < endPoint.y {
                return startPoint
            }
            return endPoint
        default:
            if startPoint.x < endPoint.x {
                return startPoint
            }
            return endPoint
        }
    }
    
    var lineMaxPoint: CGPoint {
        switch dimension {
        case 1:
            if startPoint.y > endPoint.y {
                return startPoint
            }
            return endPoint
        default:
            if startPoint.x > endPoint.x {
                return startPoint
            }
            return endPoint
        }
    }
    
    init(dimension: Int, point: CGPoint) {
        self.dimension = dimension
        self.point = point
        self.startPoint = point
        self.endPoint = point
    }
    
    func update(right node: KGKDimensionNode) {
        self.right = node
    }
    
    func update(left node: KGKDimensionNode) {
        self.left = node
    }
    
    func update(parent: KGKDimensionNode) {
        self.parent = parent
    }
    
    func line(in frame: CGRect) -> KGLine {
        if self.parent == nil {
            switch dimension {
            case 1:
                startPoint.y = frame.maxY
                endPoint.y = frame.minY
            default:
                startPoint.x = frame.maxX
                endPoint.x = frame.minX
            }
            
            return KGLine(startPoint: startPoint, endPoint: endPoint)
        }
        
        let parent = self.parent!
        endPoint = parent.point
        
        if parent.parent == nil {
            switch dimension {
            case 1:
                endPoint.x = point.x
                startPoint.y = endPoint.y < point.y ? frame.maxY : frame.minY
            default:
                endPoint.y = point.y
                startPoint.x = endPoint.x < point.x ? frame.maxX : frame.minX
            }
            
            return KGLine(startPoint: startPoint, endPoint: endPoint)
        }
        
        let grandparent = parent.parent!
        
        switch dimension {
        case 1:
            endPoint.x = point.x
            startPoint.y = startPoint.y < parent.point.y ? grandparent.lineMinPoint.y : grandparent.lineMaxPoint.y
        default:
            endPoint.y = point.y
            startPoint.x = startPoint.x < parent.point.x ? grandparent.lineMinPoint.x : grandparent.lineMaxPoint.x
        }
        
        return KGLine(startPoint: startPoint, endPoint: endPoint)
    }
}
