//
//  KGBoidNode.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//


import SpriteKit

/// A node set to be a boid of type SKShapeNode.
///
/// Has swarm behaviour qualities, which can be adjusted, if position in neighbourhood of other boids.
class KGBoidNode: SKShapeNode {
    
    // MARK: - Constants
    
    static let uniqueName = "Boid"
    
    // MARK: - Properties
    
    /// A KGBoidNode delegate instance.
    weak var delegate: KGBoidNodeDelegate? = nil
    
    /// Returns a position in confinement frame for just initialized node.
    var initialPosition: CGPoint {
        let xPosition = CGFloat.random(min: confinementFrame.origin.x, max: confinementFrame.origin.x + confinementFrame.size.width)
        let yPosition = CGFloat.random(min: confinementFrame.origin.y, max: confinementFrame.origin.y + confinementFrame.size.height)
        return CGPoint(x: xPosition, y: yPosition)
    }
    
    /// Returns a receiver's node length.
    var length: CGFloat {
        return path?.boundingBox.width ?? 20.0
    }
    
    /// Returns a copy of a receiver's node with exactly same confinement frame.
    var clone: KGBoidNode {
        let cloneNode = self.copy() as! KGBoidNode
        
        cloneNode.setProperty(confinementFrame: self.confinementFrame)
        cloneNode.position = cloneNode.initialPosition
        
        return cloneNode
    }
    
    private var confinementFrame = CGRect.zero
    
    private var direction = CGVector.random(min: -10, max: 10)
    private var recentDirections = [CGVector]()
    
    private var referenceTraceBoidPosition = CGPoint.zero
    private var traceBoidDistanceFromMasterBoid: CGFloat = 50.0
    
    private var speedCoefficient = CGFloat(0.2)
    private var separationCoefficient = CGFloat(1)
    private(set) var alignmentCoefficient = CGFloat(0.8)
    private(set) var cohesionCoefficient = CGFloat(-1)
    
    private(set) var fillColorAlpha = CGFloat(0.4)
    
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
    
    // MARK: - SKShapeNode properties
    
    override var position: CGPoint {
        didSet {
            guard position != oldValue, position.distance(to: oldValue) > 20 else { return }
            delegate?.kgBoidNode(self, didUpdate: position)
        }
    }
    
    // MARK: - Initialization
    
    convenience init(from path: CGPath, confinementFrame: CGRect, properties: [KGBoidProperties]? = nil) {
        self.init()
        
        self.name = KGBoidNode.uniqueName
        self.path = path
        self.confinementFrame = confinementFrame
        self.position = initialPosition
        
        self.setup(using: properties)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateDirectionRandomness), userInfo: nil, repeats: true)
    }
    
    private func setup(using properties: [KGBoidProperties]?) {
        if let preferredProperties = properties {
            for propery in preferredProperties {
                switch propery {
                case .leavesTranceBoidAtDistance(let distance):
                    self.traceBoidDistanceFromMasterBoid = distance
                    
                case .fillColor(let color):
                    self.fillColor = color
                    
                case .strokeColor(let color):
                    self.strokeColor = color
                }
            }
        }
        
        let strokeColorProperty = properties?.first(where: { strokeColorProperty in
            if case .strokeColor = strokeColorProperty {
                return true
            }
            return false
        })
        
        if strokeColorProperty == nil {
            self.strokeColor = .clear
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
    
    func setProperty(fillColor: UIColor) {
        self.fillColor = fillColor
    }
    
    private func setPropertyAlpha(for neighbourCount: Int) {
        if neighbourCount > 10 {
            fillColorAlpha = 0.7
            return
        }
        
        if neighbourCount > 6 {
            fillColorAlpha = 0.6
            return
        }
        
        if neighbourCount > 3 {
            fillColorAlpha = 0.45
            return
        }
        
        fillColorAlpha = 0.4
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
    
    /// Updates boid's position and rotations based on neighbourhood/swarm boids.
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
            recentDirections = Array(recentDirections.suffix(5))
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
        
        if referenceTraceBoidPosition.distance(to: position) > traceBoidDistanceFromMasterBoid {
            referenceTraceBoidPosition = position
            spitTraceParticle()
        }
    }
    
    private func updateRotation() {
        let averageDirection = recentDirections.averageForCGVectors
        zRotation = averageDirection.normalized.angleToNormal
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
    
    @objc private func updateDirectionRandomness() {
        direction = CGVector.random(min: -10, max: 10)
    }
    
    // MARK: - Boid trace particle setup
    
    @objc func spitTraceParticle() {
        let traceNode = self.clone(color: fillColor, position: position)
        self.parent?.addChild(traceNode)
        
        let fadeOut = SKAction.fadeOut(withDuration: 1.5)
        traceNode.run(fadeOut) {
            traceNode.removeFromParent()
        }
    }
}

/// The object that acts as the delegate of KGBoidNode.
///
/// The delegate must adopt the KGBoidNodeDelegate protocol.
///
/// The delegate object is responsible for managing node's position updates.
protocol KGBoidNodeDelegate: class {
    
    /// Tells the delegate that the boid node has changed it's position.
    ///
    /// - Parameters:
    ///     - node: A node which position has changed.
    ///     - position: A new node's position.
    func kgBoidNode(_ node: KGBoidNode, didUpdate position: CGPoint)
}
