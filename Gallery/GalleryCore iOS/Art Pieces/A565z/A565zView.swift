//
//  A565zView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 6/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

#if os(iOS)
import ArtKit_iOS
#elseif os(tvOS)
import ArtKit_tvOS
#endif

public class A565zView: ArtView {

    private lazy var scene: SKScene! = {
        guard let gameScenePath = Bundle(for: type(of: self)).path(forResource: "A565zScene", ofType: "sks") else {
            fatalError()
        }
        
        guard let gameSceneData = FileManager.default.contents(atPath: gameScenePath) else {
            fatalError()
        }
        
        return NSKeyedUnarchiver.unarchiveObject(with: gameSceneData) as? SKScene
    }()

    public required init(frame: CGRect) {
        super.init(frame: frame)
        

        backgroundColor = .white

        let spriteKitView = SKView(frame: .zero)
        addSubview(spriteKitView)
        spriteKitView.autolayoutFill(parent: self)
        
        sendSubview(toBack: spriteKitView)
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = false
        spriteKitView.showsNodeCount = false
        spriteKitView.presentScene(scene)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard var size = newSuperview?.frame.size else { return }
        if size == .zero {
            size = superview?.frame.size ?? UIScreen.main.bounds.size
        }
        scene.size = size
//        scene.clearScreen()
    }

    
}
