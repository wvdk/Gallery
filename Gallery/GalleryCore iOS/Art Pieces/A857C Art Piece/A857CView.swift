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

    // MARK: - Properties
    
    let scene = SKScene()
    let containerNode = SKNode()
    let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        tag = 127
        
        addSubview(spriteKitView)
        spriteKitView.constraint(edgesTo: self)
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = false
        spriteKitView.showsNodeCount = false

        sendSubview(toBack: spriteKitView)
        spriteKitView.presentScene(scene)
        
        scene.scaleMode = .aspectFill
        scene.addChild(containerNode)        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard var size = newSuperview?.frame.size else { return }
        if size == .zero {
            size = superview?.frame.size ?? UIScreen.main.bounds.size
        }
        scene.size = size
        addShaderNode(nodeSize: size)
    }
    
    // MARK: - Node appearance
    
    /// Adds `SKSpriteNode` with shader to the scene.
    private func addShaderNode(nodeSize: CGSize = .zero) {
        let node = SKSpriteNode(color: .white, size: nodeSize)
        node.position = CGPoint(x: nodeSize.width / 2, y: nodeSize.height / 2)
        node.zPosition = 100
        
        let shader = SKShader(fileNamed: "A857CFragmentShader.fsh")
        node.addShader(shader: shader)
        
        containerNode.removeAllChildren()
        containerNode.addChild(node)
    }
}
