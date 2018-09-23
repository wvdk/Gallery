//
//  KGBoidsFireView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class KGBoidsFireView: UIView {
    
    // MARK: - Properties
    
    private var scene = KGBoidsFireScene()
    private let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
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
