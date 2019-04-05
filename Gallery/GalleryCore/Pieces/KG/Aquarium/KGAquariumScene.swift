//
//  KGAquariumScene.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 3/30/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGAquariumScene: SKScene {
    
    private let water = SKSpriteNode(imageNamed: "KGAquarium/Water")
    private let grassFront = SKSpriteNode(imageNamed: "KGAquarium/Grass1")
    private let grassBack = SKSpriteNode(imageNamed: "KGAquarium/Grass2")

    private let waterZ: CGFloat = 0
    private let bubbleZ: CGFloat = 12
    private let fishZ: CGFloat = 12

    override init(size: CGSize) {
        super.init(size: size)
        
        addChild(water)
        addChild(grassFront)
        addChild(grassBack)
        
        water.zPosition = waterZ
        grassFront.zPosition = fishZ + 10
        grassBack.zPosition = grassFront.zPosition - 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size

        water.size = size
        grassFront.size = size
        grassBack.size = size

        let center = CGPoint(x: size.width / 2, y: size.height / 2)

        water.position = center
        grassFront.position = center
        grassBack.position = center

        configureGrassFrontSwing()
        configureGrassBackSwing()

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
    }
    
    private func configureBubbles(){
        guard let bubbles = SKEmitterNode(fileNamed: "KGBubbleParticles") else {
            return
        }
        
        bubbles.position = CGPoint(x: size.width / 2, y: 0)
        bubbles.particlePositionRange.dx = size.width / 2
        bubbles.zPosition = bubbleZ
        bubbles.alpha = 0.2
        bubbles.particleLifetime = 10.0
        bubbles.particleBirthRate = 1
        
        addChild(bubbles)
    }
    
    private func configureGrassFrontSwing(){
        let sourcePositions: [float2] = [
            float2(0, 1),       float2(0.5, 1),     float2(1, 1),
            float2(0, 0.6),     float2(0.5, 0.6),   float2(1, 0.6),
            float2(0, 0),       float2(0.5, 0),     float2(1, 0)
        ]
        
        let destinationPositions1: [float2] = [
            float2(0.05, 0.99),  float2(0.55, 0.98),  float2(1.05, 0.96),
            float2(0.01, 0.59),  float2(0.51, 0.58),  float2(1.01, 0.56),
            float2(0, 0),        float2(0.5, 0),      float2(1, 0)
        ]
        
        let destinationPositions2: [float2] = [
            float2(0.1, 0.98),   float2(0.6, 0.96),   float2(1.1, 0.92),
            float2(0.02, 0.58),  float2(0.52, 0.56),  float2(1.02, 0.52),
            float2(0, 0),        float2(0.5, 0),      float2(1, 0)
        ]
        
        let destinationPositions3: [float2] = [
            float2(-0.04, 1),   float2(0.46, 1),    float2(0.97, 1),
            float2(0, 0.6),     float2(0.5, 0.6),   float2(1, 0.6),
            float2(0, 0),       float2(0.5, 0),     float2(1, 0)
        ]
        
        let warpGeometryGrid1 = SKWarpGeometryGrid(columns: 2, rows: 2,
                                                   sourcePositions: sourcePositions,
                                                   destinationPositions: destinationPositions1)
        let warpGeometryGrid2 = SKWarpGeometryGrid(columns: 2, rows: 2,
                                                   sourcePositions: sourcePositions,
                                                   destinationPositions: destinationPositions2)
        let warpGeometryGrid3 = SKWarpGeometryGrid(columns: 2, rows: 2,
                                                   sourcePositions: sourcePositions,
                                                   destinationPositions: destinationPositions3)
        
        let time = drand48() + 1.0
        let swingAction = SKAction.animate(withWarps:[warpGeometryGrid1, warpGeometryGrid2, warpGeometryGrid3],
                                           times: [NSNumber(value: time), NSNumber(value: time * 2), NSNumber(value: time * 3)])
        let warpAction = SKAction.repeatForever(swingAction!)
        grassFront.run(warpAction)
    }
    
    private func configureGrassBackSwing(){
        let sourcePositions: [float2] = [
            float2(0, 1),       float2(0.5, 1),     float2(1, 1),
            float2(0, 0.8),     float2(0.5, 0.8),   float2(1, 0.8),
            float2(0, 0.4),     float2(0.5, 0.4),   float2(1, 0.4),
            float2(0, 0),       float2(0.5, 0),     float2(1, 0)
        ]
        
        let destinationPositions1: [float2] = [
            float2(-0.05, 1.05),   float2(0.45, 1.1),    float2(1.05, 1),
            float2(-0.03, 0.79),   float2(0.47, 0.82),   float2(1.03, 0.85),
            float2(0, 0.35),       float2(0.54, 0.3),    float2(0.95, 0.45),
            float2(0, -0.1),       float2(0.3, 0.1),     float2(1.1, 0.1)
        ]
        
        let destinationPositions2: [float2] = [
            float2(0.1, 0.98),    float2(0.6, 0.99),   float2(1.1, 0.92),
            float2(0.06, 0.78),   float2(0.5, 0.76),  float2(1.06, 0.8),
            float2(0.01, 0.4),    float2(0.51, 0.3),  float2(1.01, 0.38),
            float2(0, 0),         float2(0.5, 0),      float2(1, 0)
        ]
        
        let destinationPositions3: [float2] = [
            float2(0.04, 1),     float2(0.46, 1.1),   float2(0.97, 1.1),
            float2(0.04, 0.8),     float2(0.47, 0.8),   float2(0.98, 0.8),
            float2(0.02, 0.4),      float2(0.4, 0.4),    float2(1.06, 0.4),
            float2(0, 0),           float2(0.5, 0),      float2(1, 0)
        ]
        
        let warpGeometryGrid1 = SKWarpGeometryGrid(columns: 2, rows: 3,
                                                   sourcePositions: sourcePositions,
                                                   destinationPositions: destinationPositions1)
        let warpGeometryGrid2 = SKWarpGeometryGrid(columns: 2, rows: 3,
                                                   sourcePositions: sourcePositions,
                                                   destinationPositions: destinationPositions2)
        let warpGeometryGrid3 = SKWarpGeometryGrid(columns: 2, rows: 3,
                                                   sourcePositions: sourcePositions,
                                                   destinationPositions: destinationPositions3)
        
        let time = drand48() + 1.0
        let swingAction = SKAction.animate(withWarps:[warpGeometryGrid1, warpGeometryGrid2, warpGeometryGrid3],
                                           times: [NSNumber(value: time), NSNumber(value: time * 2), NSNumber(value: time * 3)])
        let warpAction = SKAction.repeatForever(swingAction!)
        grassBack.run(warpAction)
    }
}
