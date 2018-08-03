//
//  A565zView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 6/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SceneKit

#if os(iOS)
import ArtKit_iOS
#elseif os(tvOS)
import ArtKit_tvOS
#endif

public class A565zView: ArtView {
    
    // MARK: - Properties
    
    private let sceneKitView = SCNView()
    private let scene = SCNScene()
    private let containerNode = SCNNode()
    
    // MARK: - Initialization

    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        tag = 123
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        
        addSubview(sceneKitView)
        sceneKitView.translatesAutoresizingMaskIntoConstraints = false
        sceneKitView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sceneKitView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        sceneKitView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sceneKitView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sceneKitView.scene = scene
        sceneKitView.allowsCameraControl = false
        
        scene.rootNode.addChildNode(containerNode)
        
        createNodeAtCenter()        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Node creation
    
    private func createNodeAtCenter() {
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
