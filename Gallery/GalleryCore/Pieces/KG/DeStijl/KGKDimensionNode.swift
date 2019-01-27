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
    
    private var startPoint: CGPoint?
    private var endPoint: CGPoint?
    
    private var coordinate: CGFloat {
        switch dimension {
        case 1:
            return point.x
        default:
            return point.y
        }
    }
    
    var lineMinPoint: CGPoint? {
        switch dimension {
        case 1:
            if startPoint!.y < endPoint!.y {
                return startPoint
            }
            return endPoint
        default:
            if startPoint!.x < endPoint!.x {
                return startPoint
            }
            return endPoint
        }
    }
    
    var lineMaxPoint: CGPoint? {
        switch dimension {
        case 1:
            if startPoint!.y > endPoint!.y {
                return startPoint
            }
            return endPoint
        default:
            if startPoint!.x > endPoint!.x {
                return startPoint
            }
            return endPoint
        }
    }
    
    @discardableResult func line(in frame: CGRect) -> KGLine {
        startPoint = point
        endPoint = point
        
        guard let parent = self.parent else {
            switch dimension {
            case 1:
                startPoint?.y = frame.maxY
                endPoint?.y = frame.minY
            default:
                startPoint?.x = frame.maxX
                endPoint?.x = frame.minX
            }
            
            return KGLine(startPoint: startPoint ?? point, endPoint: endPoint ?? point)
        }
        
        endPoint = parent.point
        
        guard let grandparent = parent.parent else {
            switch dimension {
            case 1:
                endPoint?.x = point.x
                
                if endPoint!.y < point.y {
                    startPoint?.y = frame.maxY
                } else {
                    startPoint?.y = frame.minY
                }
            default:
                endPoint?.y = point.y
                
                if endPoint!.x < point.x {
                    startPoint?.x = frame.maxX
                } else {
                    startPoint?.x = frame.minX
                }
            }
            return KGLine(startPoint: startPoint ?? point, endPoint: endPoint ?? point)
        }
        
        switch dimension {
        case 1:
            endPoint?.x = point.x
            
            if startPoint!.y < parent.point.y {
                startPoint?.y = grandparent.lineMinPoint?.y ?? point.y
            } else {
                startPoint?.y = grandparent.lineMaxPoint?.y ?? point.y
            }
            
        default:
            endPoint?.y = point.y
            
            if startPoint!.x < parent.point.x {
                startPoint?.x = grandparent.lineMinPoint?.x ?? point.x
            } else {
                startPoint?.x = grandparent.lineMaxPoint?.x ?? point.x
            }
        }
        
        return KGLine(startPoint: startPoint ?? point, endPoint: endPoint ?? point)
    }
    
    init(dimension: Int, point: CGPoint) {
        self.dimension = dimension
        self.point = point
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
}
