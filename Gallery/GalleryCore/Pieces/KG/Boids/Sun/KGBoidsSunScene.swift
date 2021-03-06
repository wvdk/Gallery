//
//  KGBoidsSunScene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

class KGBoidsSunScene: SKScene {
    
    // MARK: - Properties
    
    private var boidsController: KGBoidsController!
    private var canEstimateBoidsNeighbourhood = false

    // MARK: - Scene presentation
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = UIColor(r: 93, g: 0, b: 0)
        
        let boidsLength = size.width * 0.0036
        let sizeWidth = size.height * 0.5
        let sizeHeight = size.height * 0.5
        let confinementFrame = CGRect(origin: CGPoint(x: size.width / 2 - sizeWidth / 2, y: size.height / 2 - sizeHeight / 2),
                                      size: CGSize(width: sizeWidth, height: sizeHeight))
        
        boidsController = KGBoidsController(bucketSize: boidsLength * 2, confinementFrame: confinementFrame)
        
        setupBackgroundNode()
        setupCirculatObstacleNode(for: confinementFrame)
        
        let initialLeftFrame = CGRect(x: -frame.size.width,
                                      y: confinementFrame.midY,
                                      width: frame.size.width * 1.5 - confinementFrame.size.width / 2,
                                      height: 5)
        let initialRightFrame = CGRect(x: frame.size.width / 2 + confinementFrame.size.width / 2,
                                       y: confinementFrame.midY,
                                       width: frame.size.width * 1.5 - confinementFrame.size.width / 2,
                                       height: 5)
        
        setupBoids(in: initialLeftFrame, boidsLength: boidsLength)
        setupBoids(in: initialRightFrame, boidsLength: boidsLength)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.updateColor()
        }
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
    
    var colorIndex = 0

    private func updateColor() {
        var color: UIColor
        colorIndex += 5

        if colorIndex < 95 {
            color = UIColor(r: 93, g: 0, b: colorIndex)
        } else if colorIndex > 190 {
            color = UIColor(r: 0, g: 0, b: 0)
            colorIndex = 0
        } else {
            color = UIColor(r: 93 - colorIndex + 95, g: 0, b: 93)
        }
        
        self.run(SKAction.colorize(with: color, colorBlendFactor: 1, duration: 3))
    }
    
    private func setupBackgroundNode() {
        let linearGradient = CAGradientLayer()
        linearGradient.frame = CGRect(origin: .zero, size: size)
        linearGradient.colors = [
            UIColor.black.cgColor,
            UIColor(r: 0, g: 0, b: 0, alpha: 0).cgColor,
            UIColor.black.cgColor
        ]
        
        let texture = SKTexture(layer: linearGradient, size: size)
        let node = SKSpriteNode(texture: texture, size: size)
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        node.zPosition = 0
        
        addChild(node)
    }
    
    private func setupBoids(in frame: CGRect, boidsLength: CGFloat) {
        let path = KGBoidShapes.circle.cgPathRepresentative(length: boidsLength)
        let boid = KGBoidNode(from: path, properties: [.fillColor(UIColor(r: 0, g: 0, b: 0)), .initialDirection(.zero)])
        boid.zPosition = 10
        
        for _ in 0...200 {
            spitCopy(of: boid, at: frame.randomPoint)
        }
    }
    
    private func spitCopy(of boid: KGBoidNode, at position: CGPoint) {
        let cloneBoid = boid.clone(at: position)
        
        cloneBoid.setProperty(cohesionCoefficient: -0.2)
        cloneBoid.setProperty(alignmentCoefficient: 0.8)
        cloneBoid.setProperty(separationCoefficient: 0)
        cloneBoid.setProperty(speedCoefficient: 0.25)
        
        self.addChild(cloneBoid)
        boidsController.add(boid: cloneBoid)
    }
    
    private func setupCirculatObstacleNode(for frame: CGRect) {
        let node = KGObstacleNode(doghnutIn: frame)
        node.zPosition = 9
        self.addChild(node)
        boidsController.add(obstacle: node)
    }
    
    private func setupRectangularObstacleNodes(for frame: CGRect) {
        let frameThinkness: CGFloat = size.width * 0.021
        
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
        
        let leftNode = KGObstacleNode(rectangleOfFrame: leftFrame, direction: CGVector(dx: 1, dy: 0))
        let rightNode = KGObstacleNode(rectangleOfFrame: rightFrame, direction: CGVector(dx: -1, dy: 0))
        let bottomNode = KGObstacleNode(rectangleOfFrame: bottomFrame, direction: CGVector(dx: 0, dy: 1))
        let topNode = KGObstacleNode(rectangleOfFrame: topFrame, direction: CGVector(dx: 0, dy: -1))
        
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
