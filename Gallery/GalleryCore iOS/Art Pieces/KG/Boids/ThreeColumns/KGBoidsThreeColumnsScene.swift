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

    private lazy var boidNode = KGBoidNode(from: KGBoidShapes.square.cgPathRepresentative(length: 20), confinementFrame: gameSceneWorldFrame)
    private lazy var boidNode2 = KGBoidNode(from: KGBoidShapes.square.cgPathRepresentative(length: 20), confinementFrame: gameSceneWorld2Frame)
    private lazy var boidNode3 = KGBoidNode(from: KGBoidShapes.square.cgPathRepresentative(length: 20), confinementFrame: gameSceneWorld3Frame)

    private lazy var gameSceneWidth = size.width / 15
    private lazy var gameSceneHeight = size.height - 300
    
    private lazy var gameSceneWorldFrame = CGRect(origin: CGPoint(x: size.width / 2 - gameSceneWidth, y: size.height / 2 - gameSceneHeight / 2),
                                                  size: CGSize(width: 2 * gameSceneWidth, height: gameSceneHeight))
    private lazy var gameSceneWorld2Frame = CGRect(origin: CGPoint(x: size.width / 4 - gameSceneWidth / 2, y: size.height / 2 - gameSceneHeight / 2),
                                                   size: CGSize(width: gameSceneWidth, height: gameSceneHeight))
    private lazy var gameSceneWorld3Frame = CGRect(origin: CGPoint(x: size.width * 3 / 4 - gameSceneWidth / 2, y: size.height / 2 - gameSceneHeight / 2),
                                                   size: CGSize(width: gameSceneWidth, height: gameSceneHeight))
    
    // MARK: - Lifecycle functions
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        self.size = view.superview?.frame.size ?? UIScreen.main.nativeBounds.size
        self.backgroundColor = .black

        for _ in 0...50 {
            spit(boid: boidNode)
        }
        
        for _ in 0...30 {
            spit(boid: boidNode2)
        }
        
        for _ in 0...30 {
            spit(boid: boidNode3)
        }
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateBoidProperties), userInfo: nil, repeats: true)
    }
        
    override func update(_ currentTime: TimeInterval) {
        updateBoidPositions()
    }
    
    // MARK: - Node control
    
    func spit(boid: KGBoidNode) {
        let cloneBoid = boid.clone
        self.addChild(cloneBoid)
        allBoids.append(cloneBoid)
    }
    
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

