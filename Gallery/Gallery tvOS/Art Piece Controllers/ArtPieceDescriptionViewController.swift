//
//  ArtPieceDescriptionViewController.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 8/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

class ArtPieceDescriptionViewController: UIViewController {

    /// <#Description#>
    var artPieceMetadata: ArtMetadata
    
    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.constraint(edgesTo: view)
        

        
        
    }
    
    /// <#Description#>
    ///
    /// - Parameter metadata:
    init(artMetadata: ArtMetadata) {
        self.artPieceMetadata = artMetadata
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
