//
//  KGAquariumView.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 3/30/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class KGAquariumView: UIView {
    
    // MARK: - Properties
    
    private var scene = KGAquariumScene(size: .zero)
    private let spriteKitView = SKView()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(spriteKitView)
        spriteKitView.constraint(edgesTo: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard newSuperview != nil else {
            return
        }
        
        spriteKitView.presentScene(scene)
    }
}
