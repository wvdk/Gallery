//
//  KGBoidsFireScene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGBoidsFireScene: SKScene {
    
    // MARK: - Properties
    
    private var allBoids = [KGBoidNode]()
    
    // MARK: - Scene presentation
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .clear
        
        setupBackgroundNode()
        setupBoids()
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateBoidPositions()
    }
    
    // MARK: - Node setup
    
    private func setupBackgroundNode() {
        let startCenter = CGPoint(x: size.width / 2, y: size.height)
        let locations: [CGFloat] = [0, 0.6]
        let colors = [
            UIColor(r: 22, g: 108, b: 189).cgColor,
            UIColor(r: 37, g: 0, b: 0).cgColor
        ]
        let radiaGradient = RadialGradientLayer(startCenter: startCenter,
                                                endCenter: startCenter,
                                                startRadius: 0,
                                                endRadius: size.width,
                                                colors: colors,
                                                locations: locations)
        radiaGradient.frame = CGRect(origin: .zero, size: size)
        
        let texture = SKTexture(layer: radiaGradient, size: size)
        let node = SKSpriteNode(texture: texture, size: size)
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        node.zPosition = 0
        
        addChild(node)
    }
    
    func setupBoids() {
        let confinementFrame = CGRect(origin: .zero, size: size)
        let boidsLength = size.width * 10 / 1920
        let lineBoidPath = KGBoidShapes.line.cgPathRepresentative(length: boidsLength)
        let properties: [KGBoidProperties] = [.leavesTranceBoidAtDistance(boidsLength), .fillColor(.white), .confinementFrame(confinementFrame), .upDirection]
        
        let boidNode = KGBoidNode(from: lineBoidPath, properties: properties)
        boidNode.zPosition = 10
        let initialWidth = 800 / 1920 * size.width
        let initialHeight = 400 / 1080 * size.width
        let initialConfinementFrame = CGRect(x: size.width / 2 - initialWidth / 2, y: 0, width: initialWidth, height: initialHeight)
        
        for _ in 0...60 {
            spitCopy(of: boidNode, in: initialConfinementFrame)
        }
    }
    
    func spitCopy(of boid: KGBoidNode, in frame: CGRect) {
        let cloneBoid = boid.clone(at: frame.randomPoint)
        
        cloneBoid.setProperty(cohesionCoefficient: -1)
        cloneBoid.setProperty(alignmentCoefficient: 1)
        cloneBoid.setProperty(separationCoefficient: 0)
        cloneBoid.setProperty(speedCoefficient: 0.5)
        self.addChild(cloneBoid)
        allBoids.append(cloneBoid)
    }
    // MARK: - Node control
    
    private func updateBoidPositions() {
        allBoids.forEach { boid in
            let neighbourhood = allBoids.filter { possiblyNeighbourBoid in
                guard boid != possiblyNeighbourBoid else {
                    return false
                }
                
                if boid.position.distance(to: possiblyNeighbourBoid.position) < boid.length * 7 {
                    return true
                }
                
                return false
            }
            
            boid.move(in: neighbourhood)
            updateBoidsPositionIfOutOfConfinementFrame(for: boid)
            updateAppearance(for: boid)
        }
    }
    
    private func updateBoidsPositionIfOutOfConfinementFrame(for node: KGBoidNode) {
        guard node.canUpdatePosition, !node.isNodeInConfinementFrame, let confinementFrame = node.confinementFrame else { return }
        
        let min = confinementFrame.origin.x + confinementFrame.size.width / 2 - confinementFrame.size.width * 100 / 1920
        let max = confinementFrame.origin.x + confinementFrame.size.width / 2 + confinementFrame.size.width * 100 / 1920
        let newPosition = CGPoint(x: CGFloat.random(in: min...max), y: confinementFrame.origin.y + 5)
        
        node.setProperty(position: newPosition)
        
        node.canUpdatePosition = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            node.canUpdatePosition = true
        }
    }
    
    // MARK: - Node appearance
    
    fileprivate func updateAppearance(for node: KGBoidNode) {
        let normalizedY = node.position.y / size.height
        let normalizedX = node.position.x / size.width
        
        let radius = sqrt(pow(normalizedY, 2) + pow(normalizedX - 0.5, 2))
        
        if radius > 0.5 {
            node.alpha = (1 - radius)
            return
        }
        node.setProperty(alpha: radius)
    }
}
