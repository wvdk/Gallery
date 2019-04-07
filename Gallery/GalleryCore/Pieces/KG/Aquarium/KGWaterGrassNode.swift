//
//  KGWaterGrassNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 4/6/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGWaterGrassNode: SKSpriteNode {
    
    private let grass = SKSpriteNode(imageNamed: "KGAquarium.xcassets/WaterGrass")
    
    func configure(withSize size: CGSize) {
        addChild(grass)
        
        grass.size = CGSize(width: size.height * 0.64, height: size.height * 0.8)
        grass.position = CGPoint(x: grass.size.width / 2, y: grass.size.height / 2)
        grass.zPosition = KGAquariumScene.waterGrassZ
        
        configureGrassSwing()
    }
    
    private func configureGrassSwing(){
        let position1: [float2] = [
            float2(0, 1),           float2(0.5, 1),      float2(1, 1),
            float2(0.02, 0.75),     float2(0.52, 0.75),  float2(1.02, 0.75),
            float2(0, 0.5),         float2(0.5, 0.5),    float2(1, 0.5),
            float2(-0.02, 0.25),    float2(0.48, 0.25),  float2(0.98, 0.25),
            float2(0, 0),           float2(0.5, 0),      float2(1, 0)
        ]
        
        let position2: [float2] = [
            float2(0, 1),           float2(0.5, 1),       float2(1, 1),
            float2(-0.02, 0.75),    float2(0.48, 0.75),   float2(0.98, 0.75),
            float2(0, 0.5),         float2(0.5, 0.5),     float2(1, 0.5),
            float2(0.02, 0.25),     float2(0.52, 0.25),   float2(1.02, 0.25),
            float2(0, 0),           float2(0.5, 0),       float2(1, 0)
        ]
        
        let warp1 = SKWarpGeometryGrid(columns: 2,
                                       rows: 4,
                                       sourcePositions: position2,
                                       destinationPositions: position1)
        
        let warp2 = SKWarpGeometryGrid(columns: 2,
                                       rows: 4,
                                       sourcePositions: position1,
                                       destinationPositions: position2)
        
        let time = 3.0
        let time1 = NSNumber(value: time)
        let time2 = NSNumber(value: time * 2)
        guard let swingAction = SKAction.animate(withWarps: [warp1, warp2], times: [time1, time2]) else {
            return
        }
        grass.run(SKAction.repeatForever(swingAction))
    }
}
