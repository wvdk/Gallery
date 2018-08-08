//
//  ArtPieceDisplayViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UIViewController`, which displays single art piece view `ArtView` in full screen mode.
class ArtPieceDisplayViewController: UIViewController {
    
    // MARK: - Properties
    
    private var artPieceMetadata: ArtMetadata

    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artView = artPieceMetadata.viewType.init(frame: view.bounds, artPieceMetadata: artPieceMetadata)
        
        view.addSubview(artView)
        artView.translatesAutoresizingMaskIntoConstraints = false
        artView.constraint(edgesTo: view)
    }
    
    // MARK: - Initalization
    
    /// Initializes and returns a newly allocated view object with the specified `artMetadata` art piece view.
    ///
    /// - Parameters:
    ///     - artMetadata: Metadata of the art piece which will to be presented.
    ///
    /// - Returns: `UIViewController` with child view of art piece.
    init(artMetadata: ArtMetadata) {
        self.artPieceMetadata = artMetadata
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
