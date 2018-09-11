//
//  KGBoidNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//


import SpriteKit

class KGBoidNode: SKShapeNode {
    
    // MARK: - Constants
    
    static let uniqueName = "Boid"
    
    // MARK: - Properties
    
    var initPosition: CGPoint {
        let xPosition = CGFloat.random(min: confinementFrame.origin.x, max: confinementFrame.origin.x + confinementFrame.size.width)
        let yPosition = CGFloat.random(min: confinementFrame.origin.y, max: confinementFrame.origin.y + confinementFrame.size.height)
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    var length: CGFloat {
        return path?.boundingBox.width ?? 20.0
    }
    
    private var confinementFrame = CGRect.zero
    
    private(set) var direction = CGVector.random(min: -10, max: 10)
    private var recentDirections = [CGVector]()
    
    private var boidsAlpha = CGFloat(0.3)
    
    private var speedCoefficient = CGFloat(0.1)
    private var separationCoefficient = CGFloat(3)
    private(set) var alignmentCoefficient = CGFloat(1)
    private(set) var cohesionCoefficient = CGFloat(1)
    

    
    private var canUpdateBoidsPosition = true
    
    private var isBoidNodeInConfinementFrame: Bool {
        return confinementFrame.contains(position)
    }
    
    private var neighbourhoodBoidCount = 0 {
        didSet {
            guard neighbourhoodBoidCount > 0, neighbourhoodBoidCount != oldValue else { return }
            setPropertyAlpha(for: neighbourhoodBoidCount)
        }
    }
    
    override var position: CGPoint {
        didSet {
            let normalizedY = position.y.normalize(to: confinementFrame.size.height + confinementFrame.origin.y)
            fillColor = UIColor(red: normalizedY * normalizedY + 0.1, green: 0.1 * normalizedY, blue: 0.4 * normalizedY + 0.3, alpha: boidsAlpha)
        }
    }
    
    // MARK: - Initialization
    
    convenience init(from path: CGPath, confinementFrame: CGRect, properties: [KGBoidProperties]? = nil) {
        self.init()
        
        self.confinementFrame = confinementFrame
        self.path = path
        
        self.name = KGBoidNode.uniqueName
        self.strokeColor = .clear
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDirectionRandomness), userInfo: nil, repeats: true)
//        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(spitTraceParticle), userInfo: nil, repeats: true)
    }
    
    // MARK: - Boid trace particle setup
    
//    @objc func spitTraceParticle() {
//        guard let traceNode = (self as? SKShapeNode)?.clone(withColor: true, withPosition: true) else { return }
//        self.parent?.addChild(traceNode)
//        
//        let fadeOut = SKAction.fadeOut(withDuration: 1)
//        traceNode.run(fadeOut) {
//            traceNode.removeFromParent()
//        }
//    }
    
    // MARK: - Boid properties update
    
    func setProperty(confinementFrame: CGRect) {
        self.confinementFrame = confinementFrame
    }
    
    func setProperty(speedCoefficient: CGFloat) {
        self.speedCoefficient = speedCoefficient
    }
    
    func setProperty(separationCoefficient: CGFloat) {
        self.separationCoefficient = separationCoefficient
    }
    
    func setProperty(alignmentCoefficient: CGFloat) {
        self.alignmentCoefficient = alignmentCoefficient
    }
    
    func setProperty(cohesionCoefficient: CGFloat) {
        self.cohesionCoefficient = cohesionCoefficient
    }
    
    private func setPropertyAlpha(for neighbourCount: Int) {
        if neighbourCount > 10 {
            boidsAlpha = 0.7
            return
        }
        
        if neighbourCount > 6 {
            boidsAlpha = 0.55
            return
        }
        
        if neighbourCount > 3 {
            boidsAlpha = 0.4
            return
        }
        
        boidsAlpha = 0.2
    }
    
    // MARK: - Boid arrangement
    
    private func arrangement(in neighbourhood: [KGBoidNode]) -> (alignmentVector: CGVector, cohesionVector: CGVector, separationVector: CGVector) {
        var directions = [direction]
        var positions = [position]
        var distances = [CGVector]()
        
        for neighbour in neighbourhood {
            directions.append(neighbour.direction)
            positions.append(neighbour.position)
            distances.append(position.vector(to: neighbour.position))
        }
        
        let averageDirection = directions.averageForCGVectors
        
        let averagaPosition = positions.averageForCGPoint
        let vectorToAveragePosition = position.vector(to: averagaPosition)
        
        let averageDistance = distances.averageForCGVectors
        let distance = averageDistance.length > length / 2 ? averageDistance : CGVector(dx: length / 2, dy: length / 2)
        
        return (averageDirection, vectorToAveragePosition, distance)
    }

    
    // MARK: - Boid movement
    
    @objc private func updateDirectionRandomness() {
        direction = CGVector.random(min: -10, max: 10)
    }
    
    func move(in neighbourhood: [KGBoidNode]) {
        if canUpdateBoidsPosition {
            if !neighbourhood.isEmpty {
                neighbourhoodBoidCount = neighbourhood.count
                
                let arragement = arrangement(in: neighbourhood)
                
                let aligment = arragement.alignmentVector.normalized.multiply(by: alignmentCoefficient)
                let cohesion = arragement.cohesionVector.normalized.multiply(by: cohesionCoefficient)
                let separation = arragement.separationVector.normalized.multiply(by: separationCoefficient)
                
                direction = aligment.add(cohesion).add(separation).multiply(by: 10)
            }
            
            recentDirections.append(direction)
            recentDirections = Array(recentDirections.suffix(15))
        }
        
        updatePosition()
//        updateRotation()
    }
    
    private func updatePosition() {
        let averageDirection = recentDirections.averageForCGVectors.multiply(by: speedCoefficient)
        
        position.x += averageDirection.dx
        position.y += averageDirection.dy
        
        if canUpdateBoidsPosition, !isBoidNodeInConfinementFrame {
            returnBoidToConfinementFrame()
            
            canUpdateBoidsPosition = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.canUpdateBoidsPosition = true
            }
        }
    }
    
    private func updateRotation() {
        let averageDirection = recentDirections.averageForCGVectors
        zRotation = averageDirection.normalized.angleToNormal * CGFloat.random(min: 0.97, max: 1.03)
    }
    
    private func returnBoidToConfinementFrame() {
        if position.x < confinementFrame.origin.x {
            position.x = confinementFrame.origin.x + confinementFrame.size.width
        }
        
        if position.x > confinementFrame.origin.x + confinementFrame.size.width {
            position.x = confinementFrame.origin.x
        }
        
        if position.y < confinementFrame.origin.y {
            position.y = confinementFrame.origin.y + confinementFrame.size.height
        }
        
        if position.y > confinementFrame.origin.y + confinementFrame.size.height {
            position.y = confinementFrame.origin.y
        }
    }
}

extension KGBoidNode {
    
    /// Returns a copy of a receiver's node with exactly same confinement frame.
    var clone: KGBoidNode {
        let cloneNode = self.copy() as! KGBoidNode
        
        cloneNode.setProperty(confinementFrame: self.confinementFrame)
        cloneNode.position = cloneNode.initPosition
        
        return cloneNode
    }
}

extension SKShapeNode {
    
    func clone(withColor: Bool = true, withPosition: Bool = true) -> SKShapeNode {
        let cloneNode = self.copy() as! SKShapeNode
        
        if withColor {
            cloneNode.fillColor = self.fillColor
            cloneNode.strokeColor = self.strokeColor
        }
        
        if withPosition {
            cloneNode.position = self.position
        }
        
        return cloneNode
    }
}
