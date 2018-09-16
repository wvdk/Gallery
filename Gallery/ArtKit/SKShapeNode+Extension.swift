//
//  SKShapeNode+Extension.swift
//  ArtKit iOS
//
//  Created by Kristina Gelzinyte on 9/12/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

extension SKShapeNode {
    
    /// Returns a copy of a receiver's node in specified color and at particular location.
    public func clone(color: UIColor, position: CGPoint) -> SKShapeNode {
        let cloneNode = self.copy() as! SKShapeNode
        cloneNode.fillColor = color
        cloneNode.position = position
        return cloneNode
    }
}
