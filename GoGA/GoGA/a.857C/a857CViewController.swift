//
//  a857CViewController.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 3/18/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class a857CViewController: ArtPieceDetailViewController {
    
    var scene: a857CGameScene! = nil
    let spriteKitView = SKView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        scene = a857CGameScene(size: view.frame.size)
        spriteKitView.with { it in
            view.addSubview(it)
            view.sendSubview(toBack: it)
            it.frame = view.frame
            it.presentScene(scene)
            it.ignoresSiblingOrder = true
            it.showsFPS = false
            it.showsNodeCount = false
        }
    }
    
}
