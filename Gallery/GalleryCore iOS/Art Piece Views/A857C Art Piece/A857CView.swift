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

    var scene: A857CScene! = nil
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
        
        sendSubview(toBack: spriteKitView)
        
        scene = A857CScene(size: frame.size)
        
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
        
        guard newSuperview != nil else { return }
        scene.size = newSuperview!.frame.size
    }
}

