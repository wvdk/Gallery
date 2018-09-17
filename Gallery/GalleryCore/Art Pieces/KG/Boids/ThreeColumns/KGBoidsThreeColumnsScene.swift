//
//  KGBoidsThreeColumnsScene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGBoidsThreeColumnsScene: SKScene {
    
    // MARK: - Properties
    
    private var allBoids = [KGBoidNode]()
    private var obstacles = [KGObstacleNode]()
    
    // MARK: - Scene presentation
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .black
        
        let sizeWidth = size.width / 4
        let sizeHeight = size.height * ( 1 - 300 / 1119)
        
        let confinementFrame = CGRect(origin: CGPoint(x: size.width / 2 - sizeWidth / 2, y: size.height / 2 - sizeHeight / 2),
                                      size: CGSize(width: sizeWidth, height: sizeHeight))
        
        setupObstacleNodes(for: confinementFrame)
        setupBoids(in: confinementFrame)
    }
    
    override func update(_ currentTime: TimeInterval) {
        updateBoidPositions()
    }
    
    // MARK: - Node setup
    
    private func setupBoids(in frame: CGRect) {
        let boidLength = size.width * 5 / 1920
        let squareBoidPath = KGBoidShapes.square.cgPathRepresentative(length: boidLength)
        let boidNode = KGBoidNode(from: squareBoidPath, properties: [.fillColor(.red)]) // .leavesTranceBoidAtDistance(boidLength),
        
        //        let confinementFrame = CGRect(origin: CGPoint(x: -frame.size.width / 2, y: -frame.size.height / 2), size: frame.size)
        
        for _ in 0...500 {
            spitCopy(of: boidNode, in: frame)
        }
    }
    
    private func spitCopy(of boid: KGBoidNode, in frame: CGRect) {
        let cloneBoid = boid.clone(at: frame.randomPoint)
        
        cloneBoid.setProperty(cohesionCoefficient: -0.1)
        cloneBoid.setProperty(alignmentCoefficient: 0.5)
        cloneBoid.setProperty(separationCoefficient: 0.01)
        cloneBoid.setProperty(speedCoefficient: 0.3)
        
        self.addChild(cloneBoid)
        allBoids.append(cloneBoid)
    }
    
    private func setupObstacleNodes(for frame: CGRect) {
        let frameThinkness: CGFloat = size.width * 40 / 1920
        
        let leftFrame = CGRect(x: frame.origin.x,
                               y: frame.origin.y,
                               width: frameThinkness,
                               height: frame.size.height)
        
        let rightFrame = CGRect(x: frame.origin.x + frame.size.width - frameThinkness,
                                y: frame.origin.y,
                                width: frameThinkness,
                                height: frame.size.height)
        
        let bottomFrame = CGRect(x: frame.origin.x,
                                 y: frame.origin.y,
                                 width: frame.size.width,
                                 height: frameThinkness)
        
        let topFrame = CGRect(x: frame.origin.x,
                              y: frame.origin.y + frame.size.height - frameThinkness,
                              width: frame.size.width,
                              height: frameThinkness)
        
        let leftNode = KGObstacleNode(frame: leftFrame, direction: CGVector(dx: 1, dy: 0))
        let rightNode = KGObstacleNode(frame: rightFrame, direction: CGVector(dx: -1, dy: 0))
        let bottomNode = KGObstacleNode(frame: bottomFrame, direction: CGVector(dx: 0, dy: 1))
        let topNode = KGObstacleNode(frame: topFrame, direction: CGVector(dx: 0, dy: -1))
        
        self.addChild(leftNode)
        self.addChild(rightNode)
        self.addChild(bottomNode)
        self.addChild(topNode)
        
        obstacles.append(leftNode)
        obstacles.append(rightNode)
        obstacles.append(bottomNode)
        obstacles.append(topNode)
    }
    
    // MARK: - Node control
    
    private func updateBoidPositions() {
        allBoids.forEach { boid in
            for obstacle in obstacles {
                if boid.canUpdatePosition, obstacle.contains(boid.position) {
                    boid.bounce(of: obstacle)
                    
                    return
                }
            }
            
            //            let neighbourhood = allBoids.filter { possiblyNeighbourBoid in
            //                guard boid != possiblyNeighbourBoid else {
            //                    return false
            //                }
            //
            //                if boid.position.distance(to: possiblyNeighbourBoid.position) < boid.length * 2 {
            //                    return true
            //                }
            //
            //                return false
            //            }
            //
            //            boid.move(in: neighbourhood)
            boid.move(in: [])
        }
    }
}
