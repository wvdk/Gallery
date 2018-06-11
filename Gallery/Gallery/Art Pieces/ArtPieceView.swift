//
//  ArtPieceView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 5/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceView: UIView {

    let artPieceMetadata: ArtPieceMetadata
    
    override init(frame: CGRect) {
        artPieceMetadata = ArtPieceMetadata(id: "", author: "", prettyPublishedDate: "", thumbnailImage: nil, viewController: a857CViewController.self, viewType: a565zView.self)

        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. We're not currently using storyboards in the project. That's probably the issue.")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        print("ArtPieceView with id \(artPieceMetadata.id) did move to super view.")
    }
    
}
