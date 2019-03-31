//
//  KGAquariumScene.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 3/30/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGAquariumScene: SKScene {

//    private var allFish = [FishNode]()
//    private var fishFoodNode = FoodNode()
//    private var fishIndex: UInt32 = 0
//    private let emitter = SKEmitterNode(fileNamed: "BubbleParticles.sks")
    
    let water = SKSpriteNode(imageNamed: "KGAquarium/Water")
    let lightOne = SKSpriteNode(imageNamed: "KGAquarium/Light1")
    let lightTwo = SKSpriteNode(imageNamed: "KGAquarium/Light2")
    let lightThree = SKSpriteNode(imageNamed: "KGAquarium/Light3")

    override init(size: CGSize) {
        super.init(size: size)
        
        addChild(water)
        addChild(lightOne)
        addChild(lightTwo)
        addChild(lightThree)
        
        water.zPosition = 0

        lightOne.zPosition = 1
        lightTwo.zPosition = 1
        lightThree.zPosition = 1

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
        
        lightOne.size = size
        lightTwo.size = size
        lightThree.size = size

        let center = CGPoint(x: size.width / 2, y: size.height / 2)

        water.position = center
        
        lightOne.position = center
        lightTwo.position = center
        lightThree.position = center

        let forwardOne = SKAction.moveBy(x: 50, y: 0, duration: 1)
        let backwardsOne = SKAction.moveBy(x: -50, y: 0, duration: 1)
        
        let moveOne = SKAction.repeatForever(SKAction.sequence([forwardOne, backwardsOne]))
        lightOne.run(moveOne)
        
        let forwardTwo = SKAction.moveBy(x: -30, y: 0, duration: 1.5)
        let backwardsTwo = SKAction.moveBy(x: 30, y: 0, duration: 1.5)
        
        let moveTwo = SKAction.repeatForever(SKAction.sequence([forwardTwo, backwardsTwo]))
        lightTwo.run(moveTwo)
        
        let forwardThree = SKAction.moveBy(x: 400, y: 0, duration: 0.5)
        let backwardsThree = SKAction.moveBy(x: -400, y: 0, duration: 0.5)
        
        let moveThree = SKAction.repeatForever(SKAction.sequence([forwardThree, backwardsThree]))
        lightThree.run(moveThree)

        // Loop to create 3 fish initially in the scene.
//        for _ in 0...5 {
//            spawnFish()
//        }
        
        // Adds bubbles to the background.
//        if let emitter = emitter {
//            emitter.position = CGPoint(x: self.size.width / 2, y: 0)
//            emitter.particlePositionRange.dx = self.size.width / 2
//            emitter.zPosition = zPositionFish - 1
//            emitter.alpha = 0.6
//            emitter.particleLifetime = 10.0
//            emitter.particleBirthRate = 0.3
//            addChild(emitter)
//        }
        
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
    override func update(_ currentTime: TimeInterval) {
    }
    
    /// Creates a new fish
//    private func spawnFish(){
//
//        fishIndex = arc4random_uniform(2) + 1
//        let fish = FishNode().newInstance(size: size, randFishNumber: fishIndex)
//        fish.size.height /= 1.5
//        fish.size.width *= 3/1.5
//        fish.zPosition += CGFloat(drand48())
//
//        let margin = size.height / 10
//        fish.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32( size.width))),
//                                y: margin + CGFloat(arc4random_uniform( UInt32( 8 * size.height / 10))))
//
//        fish.swim(randFishNumber: fishIndex)
//        fish.moveAround(in: size)
//        fish.addPhysicsBody()
//        allFish.append(fish)
//
//        addChild(fish)
//    }
    
    /// Finds closest food node for fish to seek.
//    private func closestFishFoodNode(for fish: FishNode) -> FoodNode {
//        let foodArray = self["fishFood"]
//        let sorted = foodArray.sorted {abs($0.position.x - fish.position.x) < abs($1.position.x - fish.position.x)}
//        let food = sorted[0] as! FoodNode
//        return food
//    }
    
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

