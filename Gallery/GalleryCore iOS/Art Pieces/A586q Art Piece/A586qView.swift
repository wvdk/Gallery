//
//  A586qView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/25/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import SpriteKit

class A586qView: ArtView {
    
    // MARK: - Properties
    
    private var scene = A586qScene()
    private let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        tag = 125

        addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false
        spriteKitView.constraint(edgesTo: self)
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = false
        spriteKitView.showsNodeCount = false

        spriteKitView.presentScene(scene)        
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
        scene.clearScreen()
    }
}
