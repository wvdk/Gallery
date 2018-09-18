//
//  KGBoidsController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGBoidsController {
    
    // MARK: - Properties
    
    private var buckets = [[KGBoidNode]?]()
    
    private var boids = [KGBoidNode]()
    private var obstacles = [KGObstacleNode]()
    
    private let bucketSize: CGFloat
    private let confinementFrame: CGRect
    
    private let bucketCount: Int
    
    // MARK: - Initialization
    
    init(bucketSize: CGFloat, confinementFrame: CGRect) {
        self.bucketSize = bucketSize
        self.confinementFrame = confinementFrame
        self.bucketCount = Int(confinementFrame.size.width / bucketSize) * Int(confinementFrame.size.height / bucketSize)
    }
    
    // MARK: - Boid management
    
    func add(boid: KGBoidNode) {
        boids.append(boid)
    }
    
    func add(obstacle: KGObstacleNode) {
        obstacles.append(obstacle)
    }
    
    func updateBoidsPositionInNeighbourhood() {
        setupEmptyBucket()
        
        boids.forEach { loadBoidToBucket(boid: $0) }
        
        boids.forEach { boid in
            if let obstacleInTheWay = obstacles.first(where: { $0.intercepts(withBoid: boid.position) }) {
                boid.bounce(of: obstacleInTheWay)
                
                boid.canUpdatePosition = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    boid.canUpdatePosition = true
                }
                
                return
            }
            
            if boid.canUpdatePosition, let bucketHashValue = boid.bucketHashValue, let neighbours = buckets[bucketHashValue], neighbours.count > 1 {
                boid.move(in: neighbours)
            } else {
                boid.move()
            }
        }
    }
    
    func updateBoidsPosition() {
        boids.forEach { $0.move() }
    }
    
    // MARK: - Bucket management
    
    private func setupEmptyBucket() {
        buckets = [nil]
        
        for _ in 0..<bucketCount {
            buckets.append(nil)
        }
    }
    
    private func hash(for boidPosition: CGPoint) -> Int {
        let column = Int(boidPosition.x / bucketSize)
        let row = Int(boidPosition.y / bucketSize)
        return column * row
    }
    
    private func loadBoidToBucket(boid: KGBoidNode) {
        guard let boidsPosition = boidsPosition(boid: boid) else {
            NSLog("Boid is out of confinement frame.")
            return
        }

        let hashValue = hash(for: boidsPosition)
        boid.bucketHashValue = hashValue
        
        if buckets[hashValue] == nil {
            buckets[hashValue] = []
        }
        
        buckets[hashValue]!.append(boid)
    }
    
    private func boidsPosition(boid: KGBoidNode) -> CGPoint? {
        let adjustedBoidPosition = CGPoint(x: boid.position.x - confinementFrame.origin.x, y: boid.position.y - confinementFrame.origin.y)

        if adjustedBoidPosition.x < 0 || adjustedBoidPosition.y < 0 || adjustedBoidPosition.x > confinementFrame.size.width || adjustedBoidPosition.y > confinementFrame.size.height {
            return nil
        }
        
        return adjustedBoidPosition
    }
}
