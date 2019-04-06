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

        for _ in 0...5 {
            configureFish()
        }
        
        configureBubbles()
    }
    
    // Called before each frame is rendered
//    override func update(_ currentTime: TimeInterval) {
//    }
    
    private func configureFish(){
        let fish = KGFishNode()
        fish.zPosition = KGAquariumScene.fishZ + CGFloat.random(in: 0...1)

        let scaleConstant = CGFloat.random(in: 0.25...0.4)
        fish.size.height *= scaleConstant
        fish.size.width *= scaleConstant
        
        let margin = size.height / 10
        fish.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32( size.width))),
                                y: margin + CGFloat(arc4random_uniform( UInt32( 8 * size.height / 10))))

        addChild(fish)

        fish.swim()
        fish.moveAround(in: size)
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
