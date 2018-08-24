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

    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        backgroundColor = .white
        
        let boid = UIView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        let image = UIImage(named: "Triangle", in: Bundle(for: type(of: self)), compatibleWith: nil)
        let imageView = UIImageView(image: image)
        boid.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalTo: boid.widthAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: boid.heightAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: boid.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: boid.centerYAnchor).isActive = true
        
        addSubview(boid)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
