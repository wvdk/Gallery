//
//  A586qView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/25/18.
//  Copyright © 2018 Gallery. All rights reserved.
//
import UIKit
import SpriteKit

class A586qView: ArtView {
    
    var scene: SKScene! = nil
    let spriteKitView = SKView()
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        tag = 125

        scene = GameScene(size: frame.size)
//        scene = PatternOneScene(size: frame.size)

        addSubview(spriteKitView)
        spriteKitView.translatesAutoresizingMaskIntoConstraints = false
        spriteKitView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        spriteKitView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        spriteKitView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        spriteKitView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
 
        spriteKitView.presentScene(scene)
        
        spriteKitView.ignoresSiblingOrder = true
        spriteKitView.showsFPS = false
        spriteKitView.showsNodeCount = false
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PatternOneScene: SKScene {
    
    var whiteRectGenerationDelay: TimeInterval? = 0.75
    
    lazy var spinAndFade = SKAction(named: "SpinAndFade")!
    lazy var moveLeft = SKAction(named: "MoveLeft")!
    lazy var moveRight = SKAction(named: "MoveRight")!
    
    /// MARK: - Lifecycle functions
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        
        self.recursivelyTriggerWhiteRectGeneration(after: whiteRectGenerationDelay)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.removeAnyOutOfFrameChildren()
    }
    
    // MARK: - Temporal pattern functions
    
    func recursivelyTriggerWhiteRectGeneration(after delay: TimeInterval?) {
        guard let delay = delay else { return }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: { [weak self] in
            guard let `self` = self else { return }
            self.generateRandomWhiteRects()
            
            guard let delay = self.whiteRectGenerationDelay else { return }
            self.recursivelyTriggerWhiteRectGeneration(after: delay +||- 0.1)
        })
    }
    
    /// MARK: - Drawing functions
    
    func getRandomAction() -> SKAction {
        let randomActionList = [moveLeft, moveRight, spinAndFade]
        
        return randomActionList.randomItem()
    }
    
    func generateRandomWhiteRects() {
        // iPhone Normal size
        let rectHeight = 100
        let rectWidth = 20
        
        for i in 0...20 {
            let whiteRect = SKSpriteNode()
            whiteRect.color = UIColor.white.withAlphaComponent(CGFloat(min(random(), 0.6)))
            whiteRect.position = CGPoint(x: self.size.width / 2, y: CGFloat(i * rectHeight))
            whiteRect.size = CGSize(width: rectWidth + Int(arc4random_uniform(UInt32(rectWidth))), height: rectHeight)
            
            self.addChild(whiteRect)
            
            whiteRect.run(getRandomAction())
        }
    }
}
