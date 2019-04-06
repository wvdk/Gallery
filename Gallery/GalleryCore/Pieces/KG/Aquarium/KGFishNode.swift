//
//  KGFishNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 4/3/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGFishNode: SKSpriteNode {
    
    var canUpdatePosition = true

    private let swingTextures = [
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing1"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing2"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing3"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing4"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing5"),
        SKTexture(imageNamed: "KGAquarium/Fish/First/Swing6")
    ]
    
    private let separationCoefficient: CGFloat = 1
    private let alignmentCoefficient: CGFloat = 0.1
    private let cohesionCoefficient: CGFloat = -1
    private let speedCoefficient: CGFloat = 0.1

    private var direction = CGVector.random(min: -10, max: 10)
    private var recentDirections = [CGVector]()
    
    convenience init() {
        self.init(texture: SKTexture(imageNamed: "KGAquarium/Fish/First/Swing1"))
        
        self.zPosition = KGAquariumScene.fishZ + CGFloat.random(in: 0...1)
    }

    func animateSwimming() {
        swing()
    }
    
    private func swing() {
        let frequency = 0.1 * (1 + Double.random(in: 0...2))
        let swing = SKAction.animate(with: swingTextures, timePerFrame: frequency)
        run(SKAction.repeatForever(swing))
    }
    
    // Boids behaviour
    
    func move(in neighbourhood: [KGFishNode] = []) {
        if neighbourhood.count > 1 {
            let arragement = arrangement(in: neighbourhood)
            
            let aligment = arragement.alignmentVector.normalized.multiply(by: alignmentCoefficient)
            let cohesion = arragement.cohesionVector.normalized.multiply(by: cohesionCoefficient)
            let separation = arragement.separationVector.normalized.multiply(by: separationCoefficient)
            
            direction = aligment.add(cohesion).add(separation).multiply(by: 10)
        }
        
        recentDirections.append(direction)
        recentDirections = Array(recentDirections.suffix(5))
        
        updatePosition()
        updateRotation()
    }
    
    private func arrangement(in neighbourhood: [KGFishNode]) -> (alignmentVector: CGVector, cohesionVector: CGVector, separationVector: CGVector) {
        var directions = [CGVector]()
        var positions = [CGPoint]()
        var distances = [CGVector]()
        
        for neighbour in neighbourhood {
            directions.append(neighbour.direction)
            positions.append(neighbour.position)
            distances.append(position.vector(to: neighbour.position))
        }
        
        guard let averageDirection = directions.average, let averagaPosition = positions.average, let averageDistance = distances.average else {
            return (.zero, .zero, .zero)
        }
        
        let vectorToAveragePosition = position.vector(to: averagaPosition)
        let distance = averageDistance.length > size.width ? averageDistance : CGVector(dx: -size.width * 0.5, dy: -size.width * 0.5)
        return (averageDirection, vectorToAveragePosition, distance)
    }
    
    private func updatePosition() {
        guard recentDirections.count > 0 else {
            return
        }
        
        guard let averageDirection = recentDirections.average?.multiply(by: speedCoefficient) else {
            return
        }
        
        position.x += averageDirection.dx
        position.y += averageDirection.dy
    }
    
    private func updateRotation() {
        guard let averageDirection = recentDirections.average else {
            return
        }
        
        zRotation = averageDirection.normalized.angleToNormal
    }
}

extension CGVector {

    fileprivate var normalized: CGVector {
        let maxComponent = max(abs(dx), abs(dy))
        
        if maxComponent == 0 {
            return .zero
        }
        
        return self.divide(by: maxComponent)
    }
}
