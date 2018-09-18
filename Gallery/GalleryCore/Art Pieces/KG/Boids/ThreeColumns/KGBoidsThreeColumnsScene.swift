//
//  KGBoidsThreeColumnsScene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGBoidsThreeColumnsScene: SKScene {
    
    // MARK: - Properties
    
    private var allBoids = [KGBoidNode]()
    private var obstacles = [KGObstacleNode]()
    
    private var buckets = [[KGBoidNode]?]()
    private var confinementFrame = CGRect.zero
    
    // MARK: - Scene presentation
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .black
        
        let sizeWidth = size.width / 4
        let sizeHeight = size.height / 2
        
        let confinementFrame = CGRect(origin: CGPoint(x: size.width / 2 - sizeWidth / 2, y: size.height / 2 - sizeHeight / 2),
                                      size: CGSize(width: sizeWidth, height: sizeHeight))
        
//        let test = SKShapeNode(rect: confinementFrame)
//        test.fillColor = .yellow
//        self.addChild(test)
        
        self.confinementFrame = confinementFrame
        
        let boidsLength = size.width * 10 / 1920
        
        setupEmptyBucket(for: confinementFrame, boidsLength: boidsLength)
        setupObstacleNodes(for: confinementFrame)
        
        let centerFrame = CGRect(x: confinementFrame.midX - confinementFrame.size.width / 4,
                                 y: confinementFrame.midY - confinementFrame.size.height / 4,
                                 width: confinementFrame.size.width / 2,
                                 height: confinementFrame.size.height / 2)
        setupBoids(in: centerFrame, boidsLength: boidsLength)
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateBoids()
    }
    
    // MARK: - Node setup
    
    private func setupBoids(in frame: CGRect, boidsLength: CGFloat) {
        let path = KGBoidShapes.circle.cgPathRepresentative(length: boidsLength)
        let boid = KGBoidNode(from: path, properties: [.fillColor(.red)])
        
        for _ in 0...500 {
            spitCopy(of: boid, in: frame)
        }
    }
    
    private func spitCopy(of boid: KGBoidNode, in frame: CGRect) {
        let cloneBoid = boid.clone(at: frame.randomPoint)
        
        cloneBoid.setProperty(cohesionCoefficient: -0.4)
        cloneBoid.setProperty(alignmentCoefficient: 0.3)
        cloneBoid.setProperty(separationCoefficient: 0.01)
        cloneBoid.setProperty(speedCoefficient: 0.3)
        
        self.addChild(cloneBoid)
        allBoids.append(cloneBoid)
    }
    
    private func setupObstacleNodes(for frame: CGRect) {
        let frameThinkness: CGFloat = size.width * 40 / 1920
        
        let leftFrame = CGRect(x: frame.origin.x,
                               y: frame.origin.y,
                               width: frameThinkness,
                               height: frame.size.height)
        
        let rightFrame = CGRect(x: frame.origin.x + frame.size.width - frameThinkness,
                                y: frame.origin.y,
                                width: frameThinkness,
                                height: frame.size.height)
        
        let bottomFrame = CGRect(x: frame.origin.x + frameThinkness,
                                 y: frame.origin.y,
                                 width: frame.size.width - 2 * frameThinkness,
                                 height: frameThinkness)
        
        let topFrame = CGRect(x: frame.origin.x + frameThinkness,
                              y: frame.origin.y + frame.size.height - frameThinkness,
                              width: frame.size.width - 2 * frameThinkness,
                              height: frameThinkness)
        
        let leftNode = KGObstacleNode(frame: leftFrame, direction: CGVector(dx: 1, dy: 0))
        let rightNode = KGObstacleNode(frame: rightFrame, direction: CGVector(dx: -1, dy: 0))
        let bottomNode = KGObstacleNode(frame: bottomFrame, direction: CGVector(dx: 0, dy: 1))
        let topNode = KGObstacleNode(frame: topFrame, direction: CGVector(dx: 0, dy: -1))
        
        self.addChild(leftNode)
        self.addChild(rightNode)
        self.addChild(bottomNode)
        self.addChild(topNode)
        
        obstacles.append(leftNode)
        obstacles.append(rightNode)
        obstacles.append(bottomNode)
        obstacles.append(topNode)
    }
    
    // MARK: - Node control

    private func updateBoids() {
        setupEmptyBucket(for: confinementFrame, boidsLength: allBoids.first!.length)
        
        allBoids.forEach { boid in
            placeBoidToBucket(boid: boid)
        }
        
        allBoids.forEach { boid in
            if let bucketHashValue = boid.bucketHashValue, let neighbours = buckets[bucketHashValue]?.filter({ $0 != boid }), neighbours.count > 0 {
                boid.move(in: neighbours)
            } else {
                boid.move()
            }
            
            if let obstacleInTheWay = obstacles.first(where: { $0.contains(boid.position) }) {
                boid.bounce(of: obstacleInTheWay)
            }
        }
    }
    
    // MARK: - Bucket management
    
    private func placeBoidToBucket(boid: KGBoidNode) {
        let hashValue = hash(for: boid.position, boidsLength: boid.length, in: confinementFrame)
        boid.bucketHashValue = hashValue
        
        if buckets[hashValue] == nil {
            buckets[hashValue] = []
        }
        
        buckets[hashValue]!.append(boid)
    }
    
    private func setupEmptyBucket(for frame: CGRect, boidsLength: CGFloat) {
        let columnCount = Int(confinementFrame.size.width / (boidsLength * 3))
        let rowCount = Int(confinementFrame.size.height / (boidsLength * 3))
        
        buckets = [nil]
        for _ in 0..<columnCount * rowCount {
            buckets.append(nil)
        }
    }
    
    private func hash(for boidPosition: CGPoint, boidsLength: CGFloat, in frame: CGRect) -> Int {
        let boidsAdjustedPosition = CGPoint(x: boidPosition.x - confinementFrame.origin.x, y: boidPosition.y - confinementFrame.origin.y)
        
        if boidsAdjustedPosition.x < 0 || boidsAdjustedPosition.y < 0 || boidsAdjustedPosition.x > frame.size.width || boidsAdjustedPosition.y > frame.size.height {
            return 0
        }
        
        let column = Int(boidsAdjustedPosition.x / (boidsLength * 3))
        let row = Int(boidsAdjustedPosition.y / (boidsLength * 3))
        
        return column * row
    }
}
