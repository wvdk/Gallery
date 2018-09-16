//
//  ArtPieceDetailViewController.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import GalleryCore_iOS

/// <#Description#>
class ArtPieceDetailViewController: UIViewController {
    
    /// <#Description#>
    let infoBarView = InfoBarView()
    
    /// <#Description#>
    var artPieceMetadata: ArtMetadata
    
    /// <#Description#>
    var artView: UIView? = nil
    
    /// <#Description#>
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.addSubview(infoBarView)
        infoBarView.translatesAutoresizingMaskIntoConstraints = false
        infoBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoBarView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        infoBarView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        infoBarView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        infoBarView.delegate = self
        
        artView = artPieceMetadata.view
        
        if let artView = artView {
            view.addSubview(artView)
            artView.translatesAutoresizingMaskIntoConstraints = false
            artView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            artView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            artView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            artView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        artView = nil
    }
    
    /// <#Description#>
    ///
    /// - Parameter metadata: <#metadata description#>
    init(metadata: ArtMetadata) {
        self.artPieceMetadata = metadata

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.bringSubviewToFront(infoBarView)
        infoBarView.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        infoBarView.show()
    }
    
}

extension ArtPieceDetailViewController: InfoBarViewDelegate {
    
    func infoBarViewDidSelectClose(_ view: UIView) {
        self.dismiss(animated: true, completion: nil)
        
        
        
        // TODO: Add the artPiece view back to the cell which presented it.
        
        
        
    }
    
}
