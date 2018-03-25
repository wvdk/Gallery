//
//  a586qViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class a586qViewController: ArtPieceDetailViewController {
    
    var scene: SKScene! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            scene = PatternOneScene(size: view.frame.size)
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
}
