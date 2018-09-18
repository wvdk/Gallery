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
    
    /// The unique boids name.
    static let uniqueName = "Boid"
    
    // MARK: - Properties
    
    /// Returns a receiver's node length.
    var length: CGFloat {
        return path?.boundingBox.width ?? 20.0
    }
    
    /// Unique hash value used for sorting boids to buckets.
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
    
    /// Boolean indicating if boid is in confinement frame.
    var isNodeInConfinementFrame: Bool {
        return confinementFrame?.contains(self.position) ?? false
    }
    
    /// Boolean indicating if boids postion can be updated, used for returning boid back to confinement frame.
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
    
    /// Updates boid's position and rotations.
    /// If neighbourhood has more that 0 boids, calculate boids swarm behavior.
    /// Otherwise move in the same direction.
    ///
    /// - Parameters:
    ///   - neighbourhood: An array of adjacent boid nodes.
    func move(in neighbourhood: [KGBoidNode] = []) {
        neighbourhoodBoidCount = neighbourhood.count

        if neighbourhoodBoidCount > 1 {
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
    
    /// Updates boid's position based on obstacle node normal vector (direction).
    ///
    /// - Parameters:
    ///   - obstacle: An obstacle node the boid is going to bounce off.
    func bounce(of obstacle: KGObstacleNode) {
        if recentDirections.count == 0 {
            NSLog("bounce - averageDirection count = 0")
            direction = obstacle.direction(at: self.position).multiply(by: -10)
        } else {
            let averageDirection = recentDirections.average!.normalized
            let directions = [averageDirection, obstacle.direction(at: self.position)]
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
        var directions = [CGVector]()
        var positions = [CGPoint]()
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
    
    @objc private func spitTraceParticle() {
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
