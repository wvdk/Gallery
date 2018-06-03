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
    
    let artPieceView = a565zView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(artPieceView)
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        artPieceView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        artPieceView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        artPieceView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        artPieceView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
}
