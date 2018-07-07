//
//  a736DViewController.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/15/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import SpriteKit

class a736DViewController: ArtPieceDetailViewController {
    
//    var scene: GameScene! = nil
    let spriteKitView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        scene = GameScene(size: view.frame.size)
        spriteKitView.with { it in
            view.addSubview(it)
            view.sendSubview(toBack: it)
            it.frame = view.frame
//            it.presentScene(scene)
            it.ignoresSiblingOrder = true
            it.showsFPS = false
            it.showsNodeCount = false
        }
    }
    
}
