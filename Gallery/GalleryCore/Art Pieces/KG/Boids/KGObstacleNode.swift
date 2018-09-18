//
//  KGObstacleNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGObstacleNode: SKShapeNode {
    
    // MARK: - Constants
    static let uniqueName = "Obstacle"
    
    // MARK: - Obstacle option list
    
    enum Shape {
        case rectangle
        case circle
    }
    
    // MARK: - Properties
    
    private var rectangleDirection = CGVector.zero
    private var shape: Shape = .rectangle
    
    // MARK: - Initialization
    
    convenience init(rectangleOfFrame: CGRect, direction: CGVector) {
        self.init(rect: rectangleOfFrame)
        self.name = KGObstacleNode.uniqueName
        
        self.fillColor = .clear
        self.strokeColor = .clear
        
        self.rectangleDirection = direction
        self.shape = .rectangle
    }
    
    convenience init(doghnutIn frame: CGRect) {
        self.init(ellipseIn: frame)
        
        self.strokeColor = .white
        self.lineWidth = 1
        
        self.shape = .circle
    }
    
    // MARK: - Initialization
    
    func direction(at point: CGPoint = .zero) -> CGVector {
        switch shape {
            
        case .rectangle:
            return rectangleDirection
            
        case .circle:
            let center = CGPoint(x: frame.midX, y: frame.midY)
            let direction = CGVector(dx: center.x - point.x, dy: center.y - point.y)
            let maxValue = max(abs(direction.dx), abs(direction.dy))
            
            if maxValue > 0 {
                return direction.divide(by: maxValue)
            }
            
            return .zero
        }
    }
    
    func intercepts(withBoid position: CGPoint) -> Bool {
        switch shape {
        case .rectangle:
            return self.contains(position)
        case .circle:
            return !self.contains(position)
        }
    }
}
