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
    private let lightOne = SKSpriteNode(imageNamed: "KGAquarium/Light1")
    private let lightTwo = SKSpriteNode(imageNamed: "KGAquarium/Light2")
    private let lightThree = SKSpriteNode(imageNamed: "KGAquarium/Light3")
    
    private let waterZ: CGFloat = 0
    private let bubbleZ: CGFloat = 12
    private let lightZ: CGFloat = 100

    override init(size: CGSize) {
        super.init(size: size)
        
        addChild(water)
        addChild(darkness)
        addChild(lightOne)
        addChild(lightTwo)
        addChild(lightThree)
        
        water.zPosition = waterZ
        darkness.zPosition = lightZ - 1
        lightOne.zPosition = lightZ
        lightTwo.zPosition = lightZ
        lightThree.zPosition = lightZ

        lightOne.alpha = 0.04
        lightTwo.alpha = 0.03
        lightThree.alpha = 0.04
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size

        water.size = size
        darkness.size = size
        lightOne.size = size
        lightTwo.size = size
        lightThree.size = size

        let center = CGPoint(x: size.width / 2, y: size.height / 2)

        water.position = center
        darkness.position = center
        lightOne.position = center
        lightTwo.position = center
        lightThree.position = center

        let forwardOne = SKAction.moveBy(x: 20, y: 0, duration: 10)
        forwardOne.timingMode = .easeInEaseOut
        let backwardsOne = forwardOne.reversed()
        
        let moveOne = SKAction.repeatForever(SKAction.sequence([forwardOne, backwardsOne]))
        lightOne.run(moveOne)
        
        let forwardTwo = SKAction.moveBy(x: -30, y: 0, duration: 10)
        forwardTwo.timingMode = .easeInEaseOut
        let backwardsTwo = forwardTwo.reversed()

        let moveTwo = SKAction.repeatForever(SKAction.sequence([forwardTwo, backwardsTwo]))
        lightTwo.run(moveTwo)

        let forwardThree = SKAction.moveBy(x: 25, y: 0, duration: 10)
        forwardThree.timingMode = .easeInEaseOut
        let backwardsThree = forwardThree.reversed()

        let moveThree = SKAction.repeatForever(SKAction.sequence([forwardThree, backwardsThree]))
        lightThree.run(moveThree)

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
        
        // Adding WorldFrame.
//        let worldFrame = CGRect(origin: CGPoint(x: frame.origin.x - 20, y: frame.origin.y - 20),
//                                size: CGSize(width: frame.size.width + 40, height: frame.size.height + 40))
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
//        self.physicsBody?.categoryBitMask = WorldCategory
//        self.physicsWorld.contactDelegate = self
    }
    
    // Called before each frame is rendered
//    override func update(_ currentTime: TimeInterval) {
//    }
    
    private func spawnFish(){
        let fish = KGFishNode()
        let scaleConstant = CGFloat.random(in: 0.25...0.4)
        fish.size.height *= scaleConstant
        fish.size.width *= scaleConstant

        let margin = size.height / 10
        fish.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32( size.width))),
                                y: margin + CGFloat(arc4random_uniform( UInt32( 8 * size.height / 10))))

        fish.swim()
        fish.moveAround(in: size)
//        fish.addPhysicsBody()
        allFish.append(fish)

        addChild(fish)
    }
    
    /// Removes fish move actions before it starts to seek food.
//    private func removeFishMoveAction(for fish: FishNode){
//        if fish.action(forKey: fishMoveAroundActionKey) != nil || fish.action(forKey: fishMoveToNewDestinationActionKey) != nil {
//            let removeAction = SKAction.run {
//                fish.removeAction(forKey: fishMoveAroundActionKey)
//                fish.removeAction(forKey: fishMoveToNewDestinationActionKey)
//            }
//            fish.run(removeAction)
//        }
//    }
}

