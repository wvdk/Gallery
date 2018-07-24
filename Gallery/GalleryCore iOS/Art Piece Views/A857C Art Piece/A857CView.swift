//
//  A857CView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import SpriteKit

class A857CView: ArtView {

    let scene = SKScene()
    let containerNode = SKNode()
    let spriteKitView = SKView()
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        tag = 127
        
        addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false
        spriteKitView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spriteKitView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        spriteKitView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spriteKitView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = false
        spriteKitView.showsNodeCount = false
        
        sendSubview(toBack: spriteKitView)
        spriteKitView.presentScene(scene)

        setupShaderNode(size: frame.size)
        scene.addChild(containerNode)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let superview = newSuperview else { return }
        let size = superview.frame.size
        scene.size = size
        setupShaderNode(size: size)
    }
    
    private func setupShaderNode(size: CGSize = .zero) {
        let shaderNode = SKSpriteNode(color: .white, size: size)
        shaderNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        shaderNode.zPosition = 100
        
        applyShader(to: shaderNode)
        
        containerNode.removeAllChildren()
        containerNode.addChild(shaderNode)
    }
    
    private func applyShader(to node: SKSpriteNode) {
        let shaderFilter = SKShader(fileNamed: "A857CFragmentShader.fsh")
        node.shader = shaderFilter

        shaderFilter.attributes = [
            SKAttribute(name: "a_sprite_size", type: .vectorFloat2)
        ]
        
        let nodeSize = vector_float2(Float(node.size.width * UIScreen.main.scale),
                                     Float(node.size.height * UIScreen.main.scale))
        
        node.setValue(SKAttributeValue(vectorFloat2: nodeSize), forAttribute: "a_sprite_size")
    }
}

