//
//  RotatingLinesView.swift
//  Gallery iOS
//
//  Created by Wesley Van der Klomp on 3/4/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SceneKit

class RotatingLinesView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = SCNView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), options: nil)
        let scene = SCNScene()
        view.scene = scene
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.autoenablesDefaultLighting = true
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(5, 0, 10)
        scene.rootNode.addChildNode(cameraNode)
        let spin = SCNAction.rotateBy(x: 0, y: 0, z: 1, duration: 20)
        let spinForever = SCNAction.repeatForever(spin)
        cameraNode.runAction(spinForever)
        
        for i in 0...100 {
            let cylinderGeometry = SCNCylinder(radius: 0.005, height: 100)
            cylinderGeometry.firstMaterial?.diffuse.contents = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            let cylinderNode = SCNNode(geometry: cylinderGeometry)
            cylinderNode.position = SCNVector3(i / 10, 0, 0)
            scene.rootNode.addChildNode(cylinderNode)
            let rotateAction = SCNAction.rotateBy(x: 3, y: 0, z: 0, duration: 10 + Double(i) * 1.5)
            let rotateForever = SCNAction.repeatForever(rotateAction)
            cylinderNode.runAction(rotateForever)
        }
        
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

