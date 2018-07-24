//
//  SKSpriteNode+Extension.swift
//  ArtKit iOS
//
//  Created by Kristina Gelzinyte on 7/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    
    /// Adds shader to ''SpriteKit'' node and sets shader's size to node's size.
    public func addShader(shader: SKShader) {
        shader.attributes = [
            SKAttribute(name: "a_sprite_size", type: .vectorFloat2)
        ]
        
        let nodeSize = vector_float2(Float(size.width * UIScreen.main.scale),
                                     Float(size.height * UIScreen.main.scale))
        self.shader = shader
        self.setValue(SKAttributeValue(vectorFloat2: nodeSize), forAttribute: "a_sprite_size")
    }
}
