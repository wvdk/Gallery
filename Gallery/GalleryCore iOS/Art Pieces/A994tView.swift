//
//  A994tView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/25/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import SceneKit

class A994tView: ArtView {
    
    // MARK: - Properties

    let scene = SCNScene()
    let containerNode = SCNNode()
    let sceneKitView = SCNView()
    
    // MARK: - Initialization

    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)

        tag = 124

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        sceneKitView.allowsCameraControl = false
        sceneKitView.backgroundColor = UIColor.white
        
        addSubview(sceneKitView)
        sceneKitView.constraint(edgesTo: self)
        
        sceneKitView.scene = scene
        
        scene.rootNode.addChildNode(containerNode)
        
        //        let rotate = SCNAction.rotate(by: 5.0, around: SCNVector3(0, 10, 0), duration: 4.0)
        //        let rotate = SCNAction.rotateBy(x: 1, y: 0, z: 0, duration: 2)
        //        let rotateForever = SCNAction.repeatForever(rotate)
        //        cameraNode.runAction(rotateForever)
        
        for i in 0...7 {
            createGrouping(offset: Double(i))
        }
        
        for _ in 0...30 {
            scattering()
        }        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Node creation

    func scattering() {
        for i in -20...20 {
            let a = Double(i)
            createSquareAt(x: random() * a, y: random() * a, z: 0)
        }
        
        for i in -20...20 {
            let a = Double(i)
            createSquareAt(x: (random() * a) * -1, y: (random() * a), z: 0)
        }
        
        for i in -20...20 {
            let a = Double(i)
            createSquareAt(x: (random() * a), y: (random() * a) * -1, z: 0)
        }
    }
    
    func createGrouping(offset: Double) {
        for _ in 0...150 {
            createSquareAt(x: random() +||- offset, y: random() +||- offset, z: 0)
        }
    }
    
    func createSquareAt(x: Double, y: Double, z: Double) {
        let plane = SCNPlane(width: 0.08, height: 0.08)
        plane.firstMaterial?.diffuse.contents = UIColor.darkGray
        
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(x: Float(x), y: Float(y), z: Float(z))
        
        //        if flipACoin() {
        let rotate = SCNAction.rotate(by: 5.0, around: SCNVector3(0, 1, 0), duration: random() + 0.5)
        let rotateForever = SCNAction.repeatForever(rotate)
        planeNode.runAction(rotateForever)
        //        } else {
        //            let rotate = SCNAction.rotate(by: 5.0, around: SCNVector3(1, 0, 0), duration: random() + 0.5)
        //            let rotateForever = SCNAction.repeatForever(rotate)
        //            planeNode.runAction(rotateForever)
        //        }
        
        containerNode.addChildNode(planeNode)
    }
}
