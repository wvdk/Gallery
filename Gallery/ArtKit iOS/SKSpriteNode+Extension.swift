//
//  SKSpriteNode+Extension.swift
//  ArtKit iOS
//
//  Created by Kristina Gelzinyte on 7/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

extension SKSpriteNode {
    
    /// Adds shader to the `node` and sets shader's size to `node`'s size.
    public func addShader(shader: SKShader) {
        let width = Float(size.width * UIScreen.main.scale)
        let height = Float(size.height * UIScreen.main.scale)
        let nodeSize = vector_float2(width, height)
        
        let nodeSizeAttributeName = "a_sprite_size"
        let nodeSizeAttributeValue = SKAttributeValue(vectorFloat2: nodeSize)
        let nodeSizeAttribute = SKAttribute(name: nodeSizeAttributeName, type: .vectorFloat2)
        
        // Creates `a_sprite_size` attribute in shader file, which means the dimension of the `node`.
        shader.attributes = [nodeSizeAttribute]
        self.setValue(nodeSizeAttributeValue, forAttribute: nodeSizeAttributeName)
        
        self.shader = shader
    }
}
