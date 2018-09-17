//
//  KGObstacleNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGObstacleNode: SKShapeNode {
    
    // MARK: - Initialization
    static let uniqueName = "Obstacle"
    
    // MARK: - Properties
    
    private(set) var direction = CGVector.zero
    
    // MARK: - Initialization
    
    convenience init(frame: CGRect, direction: CGVector) {
        self.init(rect: frame)
        self.name = KGObstacleNode.uniqueName
        
        self.fillColor = .clear
        self.strokeColor = .red
        //        self.alpha = 0
        
        self.direction = direction
    }
}
