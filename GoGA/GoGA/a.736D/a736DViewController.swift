//
//  a736DViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/15/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class a736DViewController: ArtPieceDetailViewController {
    
    var scene: GameScene! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        if let view = self.view as! SKView? {
            scene = GameScene(size: view.frame.size)
            view.presentScene(scene)
            view.ignoresSiblingOrder = true
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
}
