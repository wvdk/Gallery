//
//  KGFishNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 4/3/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGFishNode: SKSpriteNode {
    
    enum Direction {
        case left
        case right
        case none
    }

    private let swingTextures = [
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing1"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing2"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing3"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing4"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing5"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing6")
    ]
    
    public var fishSpeed: CGFloat = 0
    private var direction: Direction = .left
    private var currentTime: TimeInterval = 0.0
    
    private var fishScaleConstant: CGFloat {
        return CGFloat(drand48())
    }
    
    convenience init() {
        self.init(texture: SKTexture(imageNamed: "KGAquarium/Fish/First/Swing1"))
        
        self.zPosition = KGAquariumScene.fishZ + CGFloat.random(in: 0...1)
    }

    func animateSwimming(inSize size: CGSize) {
        swing()
        moveAround(in: size)
    }
    
    private func swing() {
        let frequency = 0.1 * (1 + Double.random(in: 0...2))
        let swing = SKAction.animate(with: swingTextures, timePerFrame: frequency)
        run(SKAction.repeatForever(swing))
    }

    private func moveAround(in size: CGSize) {
        let deltaX = size.width / 4
        let duration = 3.0 + Double(arc4random_uniform(6))
        
        if xScale < 1 {
            xScale = 1
        }
        
        let moveToPointAnimation = SKAction.move(to: CGPoint(x: self.position.x - deltaX, y: self.position.y + CGFloat(drand48())),
                                                 duration: duration)
        
        let flipAnimation = SKAction.run { [weak self] in
            self?.xScale *= -1
        }
        
        let moveBackToPointAnimation = SKAction.move(to: CGPoint(x: self.position.x + deltaX, y: self.position.y + CGFloat(drand48())),
                                                     duration: duration)
        
        let sequenceOfAnimations = SKAction.sequence([moveToPointAnimation,
                                                      flipAnimation,
                                                      moveBackToPointAnimation,
                                                      flipAnimation])
        
        run(SKAction.repeatForever(sequenceOfAnimations), withKey: "fishMoveAroundActionKey")
    }
}
