//
//  ArtView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 5/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

open class ArtView: UIView {

    open let artPieceMetadata: ArtMetadata
    
    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        self.artPieceMetadata = artPieceMetadata
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. We're not currently using storyboards in the project. That's probably the issue.")
    }
    
}
