//
//  KGBoidsThreeColumnsScene.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit
import GameplayKit

class KGBoidsThreeColumnsScene: SKScene {
    
    // MARK: - Properties
    
    private var allBoids = [KGBoidNode]()

    // MARK: - Scene presentation
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .black

        setupBoids()
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateBoidProperties), userInfo: nil, repeats: true)
    }
        
    override func update(_ currentTime: TimeInterval) {
        updateBoidPositions()
    }
    
    // MARK: - Node setup
    
    func setupBoids() {
        let sizeWidth = size.width / 15
        let sizeHeight = size.height * ( 1 - 300 / 1119)
        
        let smallFrameSize = CGSize(width: sizeWidth, height: sizeHeight)
        let doubleWidthFrameSize = CGSize(width: 2 * sizeWidth, height: sizeHeight)
        
        let centerFrame = CGRect(origin: CGPoint(x: size.width / 2 - sizeWidth, y: size.height / 2 - sizeHeight / 2), size: doubleWidthFrameSize)
        let leftFrame = CGRect(origin: CGPoint(x: size.width / 4 - sizeWidth / 2, y: size.height / 2 - sizeHeight / 2), size: smallFrameSize)
        let rightFrame = CGRect(origin: CGPoint(x: size.width * 3 / 4 - sizeWidth / 2, y: size.height / 2 - sizeHeight / 2),  size: smallFrameSize)
        
        let squareBoidPath = KGBoidShapes.square.cgPathRepresentative(length: size.width * 20 / 1920)
        
        let centerBoidNode = KGBoidNode(from: squareBoidPath, confinementFrame: centerFrame)
        let leftBoidNode = KGBoidNode(from: squareBoidPath, confinementFrame: leftFrame)
        let rightBoidNode = KGBoidNode(from: squareBoidPath, confinementFrame: rightFrame)
        
        for _ in 0...50 {
            spit(boid: centerBoidNode)
        }
        
        for _ in 0...30 {
            spit(boid: leftBoidNode)
        }
        
        for _ in 0...30 {
            spit(boid: rightBoidNode)
        }
    }
    
    func spit(boid: KGBoidNode) {
        let cloneBoid = boid.clone
        cloneBoid.delegate = self
        self.addChild(cloneBoid)
        allBoids.append(cloneBoid)
    }
    
    // MARK: - Node control
    
    @objc func updateBoidProperties() {
        let deltaValue: CGFloat = 1.0
        
        guard let boid = allBoids.first else { return }
        let currentCoeficient = boid.cohesionCoefficient

        if currentCoeficient > 0 {
            self.run(SKAction.fadeOut(withDuration: 1)) { [weak self] in
                self?.allBoids.forEach { boid in
                    boid.setProperty(cohesionCoefficient: currentCoeficient - 3 * deltaValue)
                    boid.setProperty(alignmentCoefficient: 2)
                }
                
                self?.run(SKAction.wait(forDuration: 1.5)) {
                    self?.alpha = 1
                }
            }
           
        } else {
            allBoids.forEach {
                $0.setProperty(cohesionCoefficient: currentCoeficient + deltaValue / 5)
                $0.setProperty(alignmentCoefficient: 1)
            }
        }
    }
    
    private func updateBoidPositions() {
        allBoids.forEach { boid in
            let neighbourhood = allBoids.filter { possiblyNeighbourBoid in
                guard boid != possiblyNeighbourBoid else {
                    return false
                }
                
                if boid.position.distance(to: possiblyNeighbourBoid.position) < boid.length * 2 {
                    return true
                }
                
                return false
            }
            
            boid.move(in: neighbourhood)
        }
    }
}

// MARK: - KGBoidNodeDelegate implementation

extension KGBoidsThreeColumnsScene: KGBoidNodeDelegate {
    
    func kgBoidNode(_ node: KGBoidNode, didUpdate position: CGPoint) {
        let normalizedY = node.position.y.normalize(to: size.height)
        let fillColor = UIColor(red: normalizedY * normalizedY + 0.1,
                                green: 0.1 * normalizedY,
                                blue: 0.4 * normalizedY + 0.3,
                                alpha: node.fillColorAlpha)
        node.setProperty(fillColor: fillColor)
    }
}

