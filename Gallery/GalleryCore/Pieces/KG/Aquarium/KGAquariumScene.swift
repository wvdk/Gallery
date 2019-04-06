//
//  KGAquariumScene.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 3/30/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGAquariumScene: SKScene {
    
    static let waterZ: CGFloat = 0
    static let bubbleZ: CGFloat = 12
    static let fishZ: CGFloat = 12
    static let waterGrassZ: CGFloat = 22
    
    private let water = SKSpriteNode(imageNamed: "KGAquarium/Water")
    private let waterGrass = KGWaterGrassNode()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        addChild(water)
        addChild(waterGrass)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size

        water.size = size
        water.position = CGPoint(x: size.width / 2, y: size.height / 2)
        water.zPosition = KGAquariumScene.waterZ

        waterGrass.configure(withSize: size)

        configureFish()
        configureBubbles()
    }
    
    // Called before each frame is rendered
//    override func update(_ currentTime: TimeInterval) {
//    }
    
    private func configureFish(){
        for _ in 0...5 {

            let fish = KGFishNode()
            addChild(fish)
            
            let isInFullScreen = size == UIScreen.main.bounds.size
            
            let scaleConstant = isInFullScreen ? CGFloat.random(in: 0.35...0.6) : CGFloat.random(in: 0.15...0.4)
            fish.size.height *= scaleConstant
            fish.size.width *= scaleConstant
            
            fish.position = CGPoint(x: CGFloat.random(in: 0...size.width),
                                    y: size.height / 10 + CGFloat.random(in: 0...0.8 * size.height))
            
            fish.animateSwimming(inSize: size)
        }
    }
    
    private func configureBubbles(){
        guard let bubbles = SKEmitterNode(fileNamed: "KGBubbleParticles") else {
            return
        }
        
        bubbles.position = CGPoint(x: size.width / 2, y: 0)
        bubbles.particlePositionRange.dx = size.width / 2
        bubbles.zPosition = KGAquariumScene.bubbleZ
        bubbles.alpha = 0.2
        bubbles.particleLifetime = 10.0
        bubbles.particleBirthRate = 1
        
        addChild(bubbles)
    }
}
