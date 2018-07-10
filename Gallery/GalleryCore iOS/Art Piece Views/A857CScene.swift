//
//  A857CScene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import SpriteKit

class A857CScene: SKScene {

    private let shaderFilter = SKShader(fileNamed: "TilePatternShader.fsh")
    
    override func didMove(to view: SKView) {
        let shaderNode = SKSpriteNode(color: .white, size: self.size)
        shaderNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        shaderNode.zPosition = 100
        
        applyShader(to: shaderNode)
        
        addChild(shaderNode)
    }
    
    private func applyShader(to node: SKSpriteNode){
        node.shader = shaderFilter
        
        shaderFilter.attributes = [
            SKAttribute(name: "a_sprite_size", type: .vectorFloat2)
        ]
        
        let nodeSize = vector_float2(Float(node.size.width * UIScreen.main.scale),
                                     Float(node.size.height * UIScreen.main.scale))
        
        node.setValue(SKAttributeValue(vectorFloat2: nodeSize), forAttribute: "a_sprite_size")
    }
}
