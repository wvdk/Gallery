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

    var swing1 = [
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing1"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing2"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing3")
    ]
    
    var swing2 = [
        SKTexture(imageNamed: "KGAquarium/Fish/Second/Swing1"),
        SKTexture(imageNamed: "KGAquarium/Fish/Second/Swing2"),
        SKTexture(imageNamed: "KGAquarium/Fish/Second/Swing3")
    ]
    
    public var isSeekingFishFood = false
//    public let emitter = SKEmitterNode(fileNamed: "BubbleParticles.sks")
    public var fishSpeed: CGFloat = 0
    private var direction: Direction = .left
    private var currentTime: TimeInterval = 0.0
    
    private var fishScaleConstant: CGFloat {
        return CGFloat(drand48())
    }
    
//    private var id = 0
    
    convenience init() {
        let id = Int.random(in: 1...2)
        let firstFishTexture = SKTexture(imageNamed: "KGAquarium/Fish/First/Swing1")
        let secondFishTexture = SKTexture(imageNamed: "KGAquarium/Fish/Second/Swing1")
        let texture = id == 1 ? firstFishTexture : secondFishTexture

        self.init(texture: texture)
        
        self.zPosition = 10.0 + fishScaleConstant
    }
    
//    public func addPhysicsBody(){
//        physicsBody = SKPhysicsBody.init(texture: SKTexture(imageNamed: "fishPB"), size: size)
//
//        physicsBody?.categoryBitMask = FishCategory
//        physicsBody?.contactTestBitMask = WorldCategory | FishFoodCategory
//        physicsBody?.isDynamic = false
//        physicsBody?.allowsRotation = false
//        physicsBody?.restitution = 1.0
//        physicsBody?.affectedByGravity = false
//    }
    
    public func swim(){
        let textures = Bool.random() ? swing1 : swing2
        let swing = SKAction.animate(with: textures, timePerFrame: Double(0.1 * (1 + 2 * fishScaleConstant)))
        let swimAction = SKAction.repeatForever(swing)
        run(swimAction)
        
//        if let emitter = emitter {
//            emitter.position.x = 15.0 - self.size.width / 2
//            emitter.particleScale = 0.04
//            emitter.particleScaleSpeed = 0.01
//            emitter.zPosition = zPositionFish - 10
//            addChild(emitter)
//        }
    }
    
    /// Adds swim-move action to the fish. For GAME SCENE.
    public func move(deltaTime: TimeInterval, in frameSize: CGSize){
        // Changes fish "swing" - y position.
        currentTime += deltaTime
        
        if currentTime > 2 {
            currentTime = 0
        }
        
        if currentTime >= 0 && currentTime <= 1 {
            position.y -= 0.1
        } else if currentTime > 1 && currentTime <= 2 {
            position.y += 0.1
        }
        
        var newFishSpeed = fishSpeed
        
        /// Value which shows how much x is changed every `deltaTime`.
        let deltaX: CGFloat = newFishSpeed * CGFloat(deltaTime)
        
        switch direction {
        case .left:
            position.x -= deltaX
            if position.x < -size.width / 2 {
                direction = .right
                xScale = -1
            }
            
        case .right:
            position.x += deltaX * 2
            
            if position.x > frameSize.width + size.width / 2 {
                direction = .left
                xScale = 1
            }
            
        case .none:
            break
        }
    }
    
    public func moveAround(in size: CGSize){
        
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
    
    /// Adds food following action to the fish.
//    public func seekFood(node: FoodNode){
//
//        if node.position.x > self.position.x {
//            self.xScale = -1.0
//        } else {
//            self.xScale = 1.0
//        }
//
//        self.zRotation = atan((node.position.y - self.position.y) / (node.position.x - self.position.x))
//
//        let distance = sqrt(pow((node.position.y - self.position.y), 2) + pow((node.position.x - self.position.x), 2))
//        let time = Double(distance) / 70
//
//        let seekAction = SKAction.move(to: node.position, duration: time)
//        self.run(seekAction, withKey: "fishSeekFoodActionKey")
//    }
    
    public func moveToNewDestination(in size: CGSize){
        let marginY = size.height / 3
        let destination = CGPoint(x: CGFloat(arc4random_uniform(UInt32( size.width))),
                                  y: CGFloat(arc4random_uniform(UInt32( size.height - 2 * marginY))) + marginY)
        
        if destination.x > self.position.x {
            self.xScale = -1.0
        } else {
            self.xScale = 1.0
        }
        
        self.zRotation = atan((destination.y - self.position.y) / (destination.x - self.position.x)) / 2
        
        let moveAction = SKAction.move(to: destination, duration: 10 * (1 + Double(drand48())))
        
        let moveAroundAction = SKAction.run { [weak self] in
            self?.zRotation = 0
            self?.moveAround(in: size)
        }
        
        let moveSequence = SKAction.sequence([moveAction, moveAroundAction])
        run(moveSequence, withKey: "fishMoveToNewDestinationActionKey")
    }
}
