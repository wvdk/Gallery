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
    
    private var allFishes = [KGFishNode]()
        
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
    
    override func update(_ currentTime: TimeInterval) {
        updateFishPositions()
    }
    
    private func configureFish(){
        for _ in 0...8 {

            let fish = KGFishNode()
            addChild(fish)
            allFishes.append(fish)

            let isInFullScreen = size == UIScreen.main.bounds.size
            let scaleConstant = isInFullScreen ? CGFloat.random(in: 0.35...0.6) : CGFloat.random(in: 0.15...0.4)
            fish.size.height *= scaleConstant
            fish.size.width *= scaleConstant
            
            fish.position = CGPoint(x: CGFloat.random(in: 0...size.width),
                                    y: size.height / 10 + CGFloat.random(in: 0...0.8 * size.height))
            
            fish.animateSwimming()
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
        bubbles.particleBirthRate = 2
        
        addChild(bubbles)
    }
    
    private func updateFishPositions() {
        allFishes.forEach { fish in
            let neighbourhood = allFishes.filter { possiblyNeighbourFish in
                guard fish != possiblyNeighbourFish else {
                    return false
                }
                
                if fish.position.distance(to: possiblyNeighbourFish.position) < fish.size.width * 1.5 {
                    return true
                }
                
                return false
            }
            
            fish.move(in: neighbourhood)
            updateFishPositionIfOutOfConfinementFrame(for: fish)
        }
    }
    
    private func updateFishPositionIfOutOfConfinementFrame(for node: KGFishNode) {
        guard node.canUpdatePosition, !frame.contains(node.position) else {
            return
        }
        
        let minX = frame.minY - node.size.width
        let maxY = frame.maxX + node.size.width
        let x = Bool.random() ? CGFloat.random(in: minX...frame.minY) : CGFloat.random(in: frame.maxX...maxY)
        let y = CGFloat.random(in: frame.minY...frame.maxY)
        let newPosition = CGPoint(x: x, y: y)
        
        node.position = newPosition
        
        node.canUpdatePosition = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            node.canUpdatePosition = true
        }
    }
}
