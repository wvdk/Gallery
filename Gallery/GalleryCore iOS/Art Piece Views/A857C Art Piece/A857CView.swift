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
        
        scene.scaleMode = .aspectFit
        scene.addChild(containerNode)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard var size = newSuperview?.frame.size else { return }
        if size == .zero {
            size = CGSize(width: 300, height: 300)
        }
        scene.size = size
        setupShaderNode(size: size)
    }
    
    private func setupShaderNode(size: CGSize = .zero) {
        let shaderNode = SKSpriteNode(color: .white, size: size)
        shaderNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        shaderNode.zPosition = 100
        shaderNode.addShader(shader: SKShader(fileNamed: "A857CFragmentShader.fsh"))
        
        containerNode.removeAllChildren()
        containerNode.addChild(shaderNode)
    }
}
