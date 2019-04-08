//
//  KGFishNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 4/3/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGFishNode: SKSpriteNode {
    
    var canUpdatePosition = true {
        didSet {
            if !canUpdatePosition {
                recentDirections = []
            }
        }
    }
    
    var shouldBoostSpeed = false

    private let swingTextures = [
        SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing1"),
        SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing2"),
        SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing3"),
        SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing4"),
        SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing5"),
        SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing6")
    ]
    
    private let separationCoefficient: CGFloat = 1
    private let alignmentCoefficient: CGFloat = 0.2
    private let cohesionCoefficient: CGFloat = -0.5
    private var speedCoefficient: CGFloat = 0.1 * (1 + CGFloat.random(in: 0...2))

    private var direction = CGVector(dx: Double.random(in: -10...10), dy: 0)
    private var recentDirections = [CGVector]()
    
    convenience init() {
        self.init(texture: SKTexture(imageNamed: "KGAquarium.xcassets/Fish/Swing1"))
        
        self.xScale = -1

        Timer.scheduledTimer(withTimeInterval: Double.random(in: 2...6), repeats: true) { [weak self] _ in
            self?.direction = CGVector(dx: Double.random(in: -10...10), dy: 0)
        }
    }

    func animateSwimming() {
        swing()
    }
    
    private func swing() {
        let swing = SKAction.animate(with: swingTextures, timePerFrame: Double(speedCoefficient))
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
        recentDirections = Array(recentDirections.suffix(15))
        
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
        
        guard let averageDirection = recentDirections.average?.multiply(by: speedCoefficient * (shouldBoostSpeed ? 10 : 0.8)) else {
            return
        }
        
        position.x += averageDirection.dx
        position.y += averageDirection.dy
    }
    
    private func updateRotation() {
        guard let averageDirection = recentDirections.average else {
            return
        }
        
        self.yScale = averageDirection.normalized.dx > 0 ? 1 : -1
        self.zRotation = averageDirection.normalized.angleToNormal
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
