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
    
    /// Returns a receiver's node length.
    var length: CGFloat {
        return path?.boundingBox.width ?? 20.0
    }
    
    var bucketHashValue: Int?
    
    /// Returns a copy of a receiver's node with exactly same confinement frame.
    func clone(at position: CGPoint) -> KGBoidNode {
        let cloneNode = self.copy() as! KGBoidNode
        
        cloneNode.position = position
        cloneNode.direction = CGVector.random(min: -10, max: 10)
        
        cloneNode.exclusivelyUpDirection = self.exclusivelyUpDirection
        cloneNode.traceBoidDistanceFromMasterBoid = self.traceBoidDistanceFromMasterBoid
        cloneNode.confinementFrame = self.confinementFrame
        
        return cloneNode
    }
    
    var isNodeInConfinementFrame: Bool {
        return confinementFrame?.contains(self.position) ?? false
    }
    
    var canUpdatePosition = true
    
    private(set) var confinementFrame: CGRect?
    
    private var direction = CGVector.random(min: -10, max: 10)
    private var recentDirections = [CGVector]()
    private var exclusivelyUpDirection = false
    
    private var referenceBoidPosition = CGPoint.zero
    private var referenceTraceBoidPosition = CGPoint.zero
    
    private var traceBoidDistanceFromMasterBoid: CGFloat?
    
    private var speedCoefficient = CGFloat(0.2)
    private var separationCoefficient = CGFloat(1)
    private(set) var alignmentCoefficient = CGFloat(1)
    private(set) var cohesionCoefficient = CGFloat(1)
    
    private(set) var fillColorAlpha = CGFloat(0.4)
    
    private var canUpdateBoidsPosition = true
    
    private var neighbourhoodBoidCount = 0 {
        didSet {
            guard neighbourhoodBoidCount > 0, neighbourhoodBoidCount != oldValue else { return }
            setPropertyAlpha(for: neighbourhoodBoidCount)
        }
    }
    
    // MARK: - Initialization
    
    convenience init(from path: CGPath, properties: [KGBoidProperties]? = nil) {
        self.init()
        
        self.name = KGBoidNode.uniqueName
        self.path = path
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
                    
                case .upDirection:
                    self.exclusivelyUpDirection = true
                    
                case .confinementFrame(let frame):
                    self.confinementFrame = frame
                    
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
    
    func setProperty(alpha: CGFloat) {
        self.alpha = alpha
    }
    
    func setProperty(position: CGPoint) {
        self.position = position
    }
    
    private func setPropertyAlpha(for neighbourCount: Int) {
        if neighbourCount > 10 {
            fillColorAlpha = 0.75
            return
        }
        
        if neighbourCount > 6 {
            fillColorAlpha = 0.65
            return
        }
        
        if neighbourCount > 3 {
            fillColorAlpha = 0.55
            return
        }
        
        fillColorAlpha = 0.5
    }
    
    // MARK: - Boid movement
    
    /// Updates boid's position and rotations based on neighbourhood/swarm boids.
    func move(in neighbourhood: [KGBoidNode] = []) {
        neighbourhoodBoidCount = neighbourhood.count

        if neighbourhoodBoidCount > 0 {
            let arragement = arrangement(in: neighbourhood)
            
            let aligment = arragement.alignmentVector.normalized.multiply(by: alignmentCoefficient)
            let cohesion = arragement.cohesionVector.normalized.multiply(by: cohesionCoefficient)
            let separation = arragement.separationVector.normalized.multiply(by: separationCoefficient)
            
            direction = aligment.add(cohesion).add(separation).multiply(by: 10)
        }
        
        if exclusivelyUpDirection {
            direction.dy = 7
        }
        
        recentDirections.append(direction)
        recentDirections = Array(recentDirections.suffix(5))
        
        updatePosition()
        updateRotation()
        leaveTraceBoidIfNeeded()
    }
    
    func bounce(of obstacle: KGObstacleNode) {
        if recentDirections.count == 0 {
            NSLog("bounce - averageDirection count = 0")
            direction = obstacle.direction.multiply(by: -10)
        } else {
            let averageDirection = recentDirections.average!.normalized
            let directions = [averageDirection, obstacle.direction]
            let newBoidDirection = directions.average!.multiply(by: 10)
            direction = newBoidDirection
        }
       
        recentDirections = [direction]
        updatePosition()
    }
    
    private func updatePosition() {
        guard recentDirections.count > 0 else {
            NSLog("updatePosition - averageDirection count = 0")
            return
        }
        
        let averageDirection = recentDirections.average!.multiply(by: speedCoefficient)
        
        position.x += averageDirection.dx
        position.y += averageDirection.dy
    }
    
    private func updateRotation() {
        if let averageDirection = recentDirections.average {
            zRotation = averageDirection.normalized.angleToNormal
        }
    }
    
    private func leaveTraceBoidIfNeeded() {
        if let distance = traceBoidDistanceFromMasterBoid, referenceTraceBoidPosition.distance(to: position) > distance {
            referenceTraceBoidPosition = position
            spitTraceParticle()
        }
    }
    
    @objc private func updateDirectionRandomness() {
        direction = CGVector.random(min: -10, max: 10)        
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
        
        if let averageDirection = directions.average, let averagaPosition = positions.average, let averageDistance = distances.average {
            let vectorToAveragePosition = position.vector(to: averagaPosition)
            let distance = averageDistance.length > length / 2 ? averageDistance : CGVector(dx: -length / 2, dy: -length / 2)
            return (averageDirection, vectorToAveragePosition, distance)
        }
        
        return (.zero, .zero, .zero)
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

extension CGVector {
    
    /// Returns normalized to 1 CGVector.
    fileprivate var normalized: CGVector {
        let maxComponent = max(abs(dx), abs(dy))
        
        if maxComponent == 0 {
            return .zero
        }
        
        return self.divide(by: maxComponent)
    }
}
