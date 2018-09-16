//
//  KGBoidsThreeColumnsView.swift
//  GalleryCore iOS
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class KGBoidsThreeColumnsView: ArtView {
    
    // MARK: - Properties
    
    private var scene = KGBoidsThreeColumnsScene()
    private let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        tag = 11
        
        addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false
        spriteKitView.constraint(edgesTo: self)
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = false
        spriteKitView.showsNodeCount = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        spriteKitView.presentScene(scene)
    }
}
