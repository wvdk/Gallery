//
//  A586qScene.swift
//  GalleryCore iOS
//
//  Created by Kristina Gelzinyte on 7/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class A586qScene: SKScene {
    
    // MARK: - Properties
    
    var whiteRectGenerationDelay: TimeInterval? = 0.75
    
    lazy var spinAndFade = SKAction(named: "SpinAndFade")!
    lazy var moveLeft = SKAction(named: "MoveLeft")!
    lazy var moveRight = SKAction(named: "MoveRight")!
    
    // MARK: - Lifecycle functions
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .black
        self.scaleMode = .aspectFill

        self.recursivelyTriggerWhiteRectGeneration(after: whiteRectGenerationDelay)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.removeAnyOutOfFrameChildren()
    }
    
    // MARK: - Scene reset

    func clearScreen() {
        self.removeAllChildren()
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
    
    // MARK: - Drawing functions
    
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
            whiteRect.color = UIColor.white.withAlphaComponent(CGFloat(min(CGFloat.random(in: 0...0.9), 0.6)))
            whiteRect.position = CGPoint(x: self.size.width / 2, y: CGFloat(i * rectHeight))
            whiteRect.size = CGSize(width: rectWidth + Int.random(in: 0...rectWidth), height: rectHeight)
            
            self.addChild(whiteRect)
            
            whiteRect.run(getRandomAction())
        }
    }
}
