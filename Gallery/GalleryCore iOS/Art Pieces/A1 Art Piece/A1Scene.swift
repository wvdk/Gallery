//
//  A1Scene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit
import GameplayKit

class A1Scene: SKScene {
    
    // MARK: - Properties
    
    private var allBoids = [BoidNode]()

    private lazy var boidNode = BoidNode(constrainedIn: gameSceneWorldFrame)
    
    private lazy var gameSceneWidth = size.width / 10
    private lazy var gameSceneHeight = size.height - 100
    private lazy var gameSceneWorldFrame = CGRect(origin: CGPoint(x: size.width / 2 - gameSceneWidth / 2, y: size.height / 2 - gameSceneHeight / 2),
                                     size: CGSize(width: gameSceneWidth, height: gameSceneHeight))
    
    private lazy var boidNode2 = BoidNode(constrainedIn: gameSceneWorld2Frame)
    private lazy var gameSceneWorld2Frame = CGRect(origin: CGPoint(x: size.width / 6 - gameSceneWidth / 2, y: size.height / 2 - gameSceneHeight / 2),
                                                   size: CGSize(width: gameSceneWidth, height: gameSceneHeight))
    
    private lazy var boidNode3 = BoidNode(constrainedIn: gameSceneWorld3Frame)
    private lazy var gameSceneWorld3Frame = CGRect(origin: CGPoint(x: size.width * 5 / 6 - gameSceneWidth / 2, y: size.height / 2 - gameSceneHeight / 2),
                                                   size: CGSize(width: gameSceneWidth, height: gameSceneHeight))
    
    // MARK: - Lifecycle functions
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .black
                
//        let testNode = SKShapeNode(rect: gameSceneWorldFrame)
//        testNode.fillColor = .red
//        self.addChild(testNode)
        
        for _ in 0...20 {
            spit(boid: boidNode, in: gameSceneWorldFrame, at: CGPoint(x: CGFloat.random(min: gameSceneWorldFrame.origin.x,
                                                                                        max: gameSceneWorldFrame.origin.x + gameSceneWorldFrame.size.width),
                                                                      y: CGFloat.random(min: gameSceneWorldFrame.origin.y,
                                                                                        max: gameSceneWorldFrame.origin.y + gameSceneWorldFrame.size.height)))
        }
        
        for _ in 0...20 {
            spit(boid: boidNode2, in: gameSceneWorld2Frame, at: CGPoint(x: CGFloat.random(min: gameSceneWorld2Frame.origin.x,
                                                                                          max: gameSceneWorld2Frame.origin.x + gameSceneWorld2Frame.size.width),
                                                                        y: CGFloat.random(min: gameSceneWorld2Frame.origin.y,
                                                                                          max: gameSceneWorld2Frame.origin.y + gameSceneWorld2Frame.size.height)))
        }
        
        for _ in 0...20 {
            spit(boid: boidNode3, in: gameSceneWorld3Frame, at: CGPoint(x: CGFloat.random(min: gameSceneWorld3Frame.origin.x,
                                                                                          max: gameSceneWorld3Frame.origin.x + gameSceneWorld3Frame.size.width),
                                                                        y: CGFloat.random(min: gameSceneWorld3Frame.origin.y,
                                                                                          max: gameSceneWorld3Frame.origin.y + gameSceneWorld3Frame.size.height)))
        }
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateBoidAlignmentCoefficient), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(updateBoidCohesionCoefficient), userInfo: nil, repeats: true)
    }
        
    override func update(_ currentTime: TimeInterval) {
        scanBoidsInNeighborhood()
        allBoids.forEach { $0.move() }
    }
    
    // MARK: - Node control
    
    func spit(boid: BoidNode, in frame: CGRect, at position: CGPoint) {
        guard let newBoidNode = boid.copy() as? BoidNode else { return }
        newBoidNode.updateConfinementFrame(frame: frame)
        newBoidNode.position = position
        self.addChild(newBoidNode)
        allBoids.append(newBoidNode)
    }
    
    func updateBoidSpeednCoefficient(to value: CGFloat) {
        allBoids.forEach { $0.speedCoefficient = value }
    }
    
    func updateBoidSeparationCoefficient(to value: CGFloat) {
        allBoids.forEach { $0.separationCoefficient = value }
    }
    
    @objc func updateBoidAlignmentCoefficient(to value: CGFloat) {
        if value <= 2 {
            allBoids.forEach { $0.alignmentCoefficient = value}
        } else {
            let random = CGFloat.random(min: 0, max: 0.5)
            
            if let boid = allBoids.first, boid.alignmentCoefficient > 1 {
                allBoids.forEach { $0.alignmentCoefficient -= random}
            } else {
                allBoids.forEach { $0.alignmentCoefficient += random}
            }
        }
    }
    
    @objc func updateBoidCohesionCoefficient(to value: CGFloat) {
        if value <= 2 {
            allBoids.forEach { $0.cohesionCoefficient = value }
        } else {
            let random = CGFloat.random(min: 0, max: 1)
            
            if let boid = allBoids.first, boid.cohesionCoefficient > 1 {
                allBoids.forEach { $0.cohesionCoefficient -= random}
            } else {
                allBoids.forEach { $0.cohesionCoefficient += random}
            }
        }
    }
    
    private func scanBoidsInNeighborhood() {
        for boid in allBoids {
            let neighbourBoids = allBoids.filter { possiblyNeighbourBoid in
                guard boid != possiblyNeighbourBoid else {
                    return false
                }
                
                if boid.position.distance(to: possiblyNeighbourBoid.position) < CGFloat(BoidNode.length * 4) {
                    return true
                }
                
                return false
            }
            
            boid.neightbourBoidNodes = neighbourBoids
        }
    }
}

