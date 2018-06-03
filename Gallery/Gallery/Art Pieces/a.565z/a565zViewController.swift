//
//  a565zViewController.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/26/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import ArtKit
import SceneKit

class a565zViewController: ArtPieceDetailViewController {
    
    let scene = SCNScene()
    let containerNode = SCNNode()
    let sceneKitView = SCNView()
    
    let artPieceView = a565zView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(artPieceView)
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        artPieceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artPieceView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        artPieceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        artPieceView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        sceneKitView.with { it in
            it.scene = scene
            it.allowsCameraControl = false
            it.backgroundColor = UIColor.white
            view.addSubview(it)
            it.frame = view.frame
        }
        
        scene.rootNode.addChildNode(containerNode)
        
        createNodeAtCenter()
    }
    
    func createNodeAtCenter() {
        let plane = SCNPlane(width: 3, height: 3)
        plane.firstMaterial?.diffuse.contents = UIColor.darkGray
        let planeNode = SCNNode(geometry: plane)
        
        planeNode.position = SCNVector3(x: containerNode.boundingBox.max.x,
                                        y: containerNode.boundingBox.max.y,
                                        z: Float(1))
        
        let action = SCNAction.scale(by: 10, duration: 10)
        planeNode.runAction(action)
        
        containerNode.addChildNode(planeNode)
    }
    
}
