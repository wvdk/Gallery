//
//  KGAquariumScene.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 3/30/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGAquariumScene: SKScene {

    private var allFish = [KGFishNode]()
//    private var fishFoodNode = FoodNode()
    
    private let water = SKSpriteNode(imageNamed: "KGAquarium/Water")
    private let darkness = SKSpriteNode(imageNamed: "KGAquarium/Darkness")
    
    private let waterZ: CGFloat = 0
    private let bubbleZ: CGFloat = 12
    private let fishZ: CGFloat = 12

    override init(size: CGSize) {
        super.init(size: size)
        
        addChild(water)
        addChild(darkness)
        
        water.zPosition = waterZ
        darkness.zPosition = fishZ + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size

        water.size = size
        darkness.size = size

        let center = CGPoint(x: size.width / 2, y: size.height / 2)

        water.position = center
        darkness.position = center

        for _ in 0...5 {
            spawnFish()
        }
        
        if let bubbles = SKEmitterNode(fileNamed: "KGBubbleParticles") {
            bubbles.position = CGPoint(x: size.width / 2, y: 0)
            bubbles.particlePositionRange.dx = size.width / 2
            bubbles.zPosition = bubbleZ
            bubbles.alpha = 0.2
            bubbles.particleLifetime = 10.0
            bubbles.particleBirthRate = 0.3
            addChild(bubbles)
        }
        
        // Adds water grass to the scene.
//        let waterGrass = SKSpriteNode(texture: SKTexture(imageNamed: "KGAquarium/Grass"))
//        waterGrass.size = size
//        waterGrass.position = CGPoint(x: size.width / 2, y: size.height / 2)
//        waterGrass.zPosition = 4
//        addChild(waterGrass)
    }
    
    // Called before each frame is rendered
//    override func update(_ currentTime: TimeInterval) {
//    }
    
    private func spawnFish(){
        let fish = KGFishNode()
        fish.zPosition = fishZ + CGFloat.random(in: 0...1)

        let scaleConstant = CGFloat.random(in: 0.25...0.4)
        fish.size.height *= scaleConstant
        fish.size.width *= scaleConstant
        
        let margin = size.height / 10
        fish.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32( size.width))),
                                y: margin + CGFloat(arc4random_uniform( UInt32( 8 * size.height / 10))))

        addChild(fish)

        fish.swim()
        fish.moveAround(in: size)
        allFish.append(fish)
    }
}

