//
//  ArtView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 5/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

public class ArtView: UIView {

    public var artPieceMetadata: ArtMetadata?
    
    public override required init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        self.artPieceMetadata = artPieceMetadata
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. We're not currently using storyboards in the project. That's probably the issue.")
    }
    
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        
//        print("ArtView with id \(artPieceMetadata.id) did move to super view.")
    }
}
