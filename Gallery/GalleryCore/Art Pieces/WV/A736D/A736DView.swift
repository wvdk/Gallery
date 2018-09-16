//
//  A736DView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/15/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import SpriteKit

class A736DView: ArtView {
    
    // MARK: - Properties
    
    var scene = A736DScene()
    let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        tag = 126
        
        addSubview(spriteKitView)
        spriteKitView.constraint(edgesTo: self)
        
        sendSubviewToBack(spriteKitView)
                
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
