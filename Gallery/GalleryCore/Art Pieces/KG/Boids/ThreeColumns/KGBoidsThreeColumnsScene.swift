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
    
    private var boidsController: KGBoidsController!
    private var canEstimateBoidsNeighbourhood = true

    // MARK: - Scene presentation
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .black
        
        let boidsLength = size.width * 5 / 1920
        let sizeWidth = size.width / 2
        let sizeHeight = size.height / 2
        let confinementFrame = CGRect(origin: CGPoint(x: size.width / 2 - sizeWidth / 2, y: size.height / 2 - sizeHeight / 2),
                                      size: CGSize(width: sizeWidth, height: sizeHeight))
        
//        let test = SKShapeNode(rect: confinementFrame)
//        test.fillColor = .yellow
//        self.addChild(test)
        
        boidsController = KGBoidsController(bucketSize: boidsLength * 2, confinementFrame: confinementFrame)
        
        setupObstacleNodes(for: confinementFrame)
        setupBoids(in: confinementFrame, boidsLength: boidsLength)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if canEstimateBoidsNeighbourhood {
            boidsController.updateBoidsPositionInNeighbourhood()
            canEstimateBoidsNeighbourhood = false
            return
        }
    
        boidsController.updateBoidsPosition()
        canEstimateBoidsNeighbourhood = true
    }
    
    // MARK: - Node setup
    
    private func setupBoids(in frame: CGRect, boidsLength: CGFloat) {
        let path = KGBoidShapes.circle.cgPathRepresentative(length: boidsLength)
        let boid = KGBoidNode(from: path, properties: [.fillColor(.red)])
        
        let initialFrame = CGRect(x: frame.midX - frame.size.width / 4,
                                       y: frame.midY - frame.size.height / 4,
                                       width: frame.size.width / 2,
                                       height: frame.size.height / 2)
        
        for _ in 0...900 {
            spitCopy(of: boid, in: initialFrame)
        }
    }
    
    private func spitCopy(of boid: KGBoidNode, in frame: CGRect) {
        let cloneBoid = boid.clone(at: frame.randomPoint)
        
        cloneBoid.setProperty(cohesionCoefficient: -0.2)
        cloneBoid.setProperty(alignmentCoefficient: 0.8)
        cloneBoid.setProperty(separationCoefficient: 0)
        cloneBoid.setProperty(speedCoefficient: 0.2)
        
        self.addChild(cloneBoid)
        boidsController.add(boid: cloneBoid)
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
        
        let bottomFrame = CGRect(x: frame.origin.x + frameThinkness,
                                 y: frame.origin.y,
                                 width: frame.size.width - 2 * frameThinkness,
                                 height: frameThinkness)
        
        let topFrame = CGRect(x: frame.origin.x + frameThinkness,
                              y: frame.origin.y + frame.size.height - frameThinkness,
                              width: frame.size.width - 2 * frameThinkness,
                              height: frameThinkness)
        
        let leftNode = KGObstacleNode(frame: leftFrame, direction: CGVector(dx: 1, dy: 0))
        let rightNode = KGObstacleNode(frame: rightFrame, direction: CGVector(dx: -1, dy: 0))
        let bottomNode = KGObstacleNode(frame: bottomFrame, direction: CGVector(dx: 0, dy: 1))
        let topNode = KGObstacleNode(frame: topFrame, direction: CGVector(dx: 0, dy: -1))
        
        self.addChild(leftNode)
        self.addChild(rightNode)
        self.addChild(bottomNode)
        self.addChild(topNode)
        
        boidsController.add(obstacle: leftNode)
        boidsController.add(obstacle: rightNode)
        boidsController.add(obstacle: bottomNode)
        boidsController.add(obstacle: topNode)
    }
}
