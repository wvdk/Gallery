//
//  ArtPieceDetailViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// <#Description#>
class ArtPieceDetailViewController: UIViewController {
    
    /// <#Description#>
    var artPieceMetadata: ArtMetadata
    
    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let artView = artPieceMetadata.viewType.init(frame: self.view.bounds, artPieceMetadata: artPieceMetadata)
        view.addSubview(artView)
        artView.translatesAutoresizingMaskIntoConstraints = false
        artView.constraint(edgesTo: view)
    }
    
    /// <#Description#>
    ///
    /// - Parameter metadata: <#metadata description#>
    init(artMetadata: ArtMetadata) {
        self.artPieceMetadata = artMetadata
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
