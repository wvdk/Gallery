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
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            it.addGestureRecognizer(tapGesture)
        }
        
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
    
    @objc
    func handleTap(_ gestureRecognize: UIGestureRecognizer) {
        // check what nodes are tapped
        let p = gestureRecognize.location(in: sceneKitView)
        let hitResults = sceneKitView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            
            // get its material
            let material = result.node.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            
            // on completion - unhighlight
            SCNTransaction.completionBlock = {
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                
                material.emission.contents = UIColor.black
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.red
            
            SCNTransaction.commit()
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
}
