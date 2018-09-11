//
//  A1View.swift
//  GalleryCore iOS
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class A1View: ArtView {
    
    // MARK: - Properties
    
    private var scene = A1Scene()
    private let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required init(frame: CGRect) {
        super.init(frame: frame)
        
        tag = 11
        
        addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false
        spriteKitView.constraint(edgesTo: self)
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = true
        spriteKitView.showsNodeCount = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        spriteKitView.presentScene(scene)
    }
}
