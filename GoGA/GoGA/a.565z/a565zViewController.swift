//
//  a565zViewController.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/26/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import ArtKit
import SceneKit

class a565zViewController: ArtPieceDetailViewController {
    
    let scene = SCNScene()
    let containerNode = SCNNode()
    let sceneKitView = SCNView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        sceneKitView.with { it in
            it.scene = scene
            it.allowsCameraControl = false
            it.backgroundColor = UIColor.white
            view.addSubview(it)
            it.frame = view.frame
        }
        
        scene.rootNode.addChildNode(containerNode)
        
    
        createSquareAt(x: 10, y: 10, z: 10)
    }
    
    func createSquareAt(x: Double, y: Double, z: Double) {
        let plane = SCNPlane(width: 0.08, height: 0.08)
        plane.firstMaterial?.diffuse.contents = UIColor.darkGray
        let planeNode = SCNNode(geometry: plane)
        planeNode.position = SCNVector3(x: Float(x), y: Float(y), z: Float(z))
        
        let rotate = SCNAction.rotate(by: 5.0, around: SCNVector3(0, 1, 0), duration: random() + 0.5)
        let rotateForever = SCNAction.repeatForever(rotate)
        planeNode.runAction(rotateForever)
        
        containerNode.addChildNode(planeNode)
    }
 
}
