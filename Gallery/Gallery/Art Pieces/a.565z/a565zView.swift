//
//  a565zView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 6/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import ArtKit
import SceneKit

class a565zView: ArtPieceView {
    
    let sceneKitView = SCNView()
    let scene = SCNScene()
    let containerNode = SCNNode()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("initing view")
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        sceneKitView.with { it in
            it.scene = scene
            it.allowsCameraControl = false
            it.backgroundColor = UIColor.white
            self.addSubview(it)
            it.frame = self.frame
        }
        
        scene.rootNode.addChildNode(containerNode)
        
        createNodeAtCenter()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
