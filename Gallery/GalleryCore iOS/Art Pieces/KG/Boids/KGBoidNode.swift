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
    static let length = 20
    
    private let circle = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
    private let defaultColor = UIColor(white: 1, alpha: 0.2)
    
    private var boidsAlpha = CGFloat(0.3)
    
    // MARK: - Properties
    
    override var position: CGPoint {
        didSet {
            let normalizedY = position.y.normalize(to: confinementFrame.size.height + confinementFrame.origin.y)
            fillColor = UIColor(red: normalizedY * normalizedY + 0.1, green: 0.1 * normalizedY, blue: 0.6 * normalizedY + 0.05, alpha: boidsAlpha)
        }
    }
    
    var initPosition: CGPoint {
        let xPosition = CGFloat.random(min: confinementFrame.origin.x, max: confinementFrame.origin.x + confinementFrame.size.width)
        let yPosition = CGFloat.random(min: confinementFrame.origin.y, max: confinementFrame.origin.y + confinementFrame.size.height)
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    var neightbourBoidNodes = [KGBoidNode]() {
        didSet {
            guard neightbourBoidNodes.count != oldValue.count, neightbourBoidNodes.count > 0 else { return }
            
            let boidsCount = CGFloat(neightbourBoidNodes.count)
            
            if boidsCount > 10 {
                boidsAlpha = 0.7
                return
            }
            
            if boidsCount > 6 {
                boidsAlpha = 0.55
                return
            }
            
            if boidsCount > 3 {
                boidsAlpha = 0.4
                return
            }
            
            boidsAlpha = 0.3
        }
    }
    
    private(set) var direction = CGVector.random(min: -10, max: 10)
    private var recentDirections = [CGVector]()
    
    private var confinementFrame = CGRect.zero
    
    private var speedCoefficient = CGFloat(0.6)
    private var separationCoefficient = CGFloat(0.35)
    private(set) var alignmentCoefficient = CGFloat(1)
    private(set) var cohesionCoefficient = CGFloat(1)
    
    
    
    private var canUpdateBoidsPosition = true
    
    private var hasNeighbourBoids: Bool {
        return !neightbourBoidNodes.isEmpty
    }
    
    private var isBoidNodeInConfinementFrame: Bool {
        return confinementFrame.contains(position)
    }
    
    
    
    private var alignmentVector: CGVector {
        return averageNeighbourhoodBoidDirection
    }
    
    private var cohesionVector: CGVector {
        return position.vector(to: averageNeighbourhoodBoidPosition)
    }
    
    private var separationVector: CGVector {
        return averageNeighbourhoodBoidDistance.multiply(by: -1.0)
    }
    
    private var averageNeighbourhoodBoidDirection: CGVector {
        var neightbourBoidNodeDirection = [direction]
        for neighbour in neightbourBoidNodes {
            neightbourBoidNodeDirection.append(neighbour.direction)
        }
        return neightbourBoidNodeDirection.averageForCGVectors
    }
    
    private var averageNeighbourhoodBoidPosition: CGPoint {
        var neightbourBoidNodePosition = [position]
        for neighbour in neightbourBoidNodes {
            neightbourBoidNodePosition.append(neighbour.position)
        }
        return neightbourBoidNodePosition.averageForCGPoint
    }
    
    private var averageNeighbourhoodBoidDistance: CGVector {
        var neightbourBoidNodeDistance = [CGVector]()
        for neighbour in neightbourBoidNodes {
            neightbourBoidNodeDistance.append(position.vector(to: neighbour.position))
        }
        
        let averageDistance = neightbourBoidNodeDistance.averageForCGVectors
        let distance = averageDistance.length > CGFloat(KGBoidNode.length) / 2 ? averageDistance : CGVector(dx: KGBoidNode.length / 2, dy: KGBoidNode.length / 2)
        
        return distance
    }
    
    // MARK: - Initialization
    
    convenience init(from path: CGPath, confinementFrame: CGRect, properties: [KGBoidProperties]? = nil) {
        self.init()
        
        self.confinementFrame = confinementFrame
        self.path = path
        
        self.name = KGBoidNode.uniqueName
        self.strokeColor = .clear
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDirectionRandomness), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(spitTraceParticle), userInfo: nil, repeats: true)
    }
    
    // MARK: - Boid trace particle setup
    
    @objc func spitTraceParticle() {
        guard let traceNode = (self as? SKShapeNode)?.clone(withColor: true, withPosition: true) else { return }
        self.parent?.addChild(traceNode)
        
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        traceNode.run(fadeOut) {
            traceNode.removeFromParent()
        }
    }
    
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
    
    // MARK: - Boid movement
    
    @objc private func updateDirectionRandomness() {
        direction = CGVector.random(min: -10, max: 10)
    }
    
    func move() {
        if canUpdateBoidsPosition {
            if hasNeighbourBoids {
                let aligment = alignmentVector.normalized.multiply(by: alignmentCoefficient)
                let cohesion = cohesionVector.normalized.multiply(by: cohesionCoefficient)
                let separation = separationVector.normalized.multiply(by: separationCoefficient)
                
                direction = aligment.add(cohesion).add(separation).multiply(by: 10)
            }
            
            recentDirections.append(direction)
            recentDirections = Array(recentDirections.suffix(20))
        }
        
        updatePosition()
        updateRotation()
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
