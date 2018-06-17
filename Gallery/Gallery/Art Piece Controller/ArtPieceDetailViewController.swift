//
//  ArtPieceDetailViewController.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

protocol ArtPieceDetailViewControllerDelegate: class {
    
    func artPieceDetailViewControllerDidSelectClose(_ viewController: UIViewController)
    
}

class ArtPieceDetailViewController: UIViewController {

    weak var delegate: ArtPieceDetailViewControllerDelegate?
    
    let artPieceInfoBarView = ArtPieceInfoBarView()
    
    var artPieceMetadata: ArtMetadata
    
    override func viewDidLoad() {
        super.viewDidLoad()

        artPieceInfoBarView.with { it in
            view.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            it.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            it.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            it.heightAnchor.constraint(equalToConstant: 100).isActive = true
            it.delegate = self
        }
        
        if let artPieceView = artPieceMetadata.view {
            view.addSubview(artPieceView)
            artPieceView.translatesAutoresizingMaskIntoConstraints = false
            artPieceView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            artPieceView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            artPieceView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            artPieceView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
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
        
        view.bringSubview(toFront: artPieceInfoBarView)
        artPieceInfoBarView.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        artPieceInfoBarView.show()
    }
}

extension ArtPieceDetailViewController: ArtPieceInfoBarViewDelegate {
    
    // MARK: - ArtPieceInfoBarView delegate
    
    func artPieceInfoBarViewWillAppear() {
        artPieceInfoBarView.show()
    }
    
    func artPieceInfoBarViewDidSelectClose(_ view: UIView) {
        self.delegate?.artPieceDetailViewControllerDidSelectClose(self)
    }
}
