//
//  NotFeaturedArtPieceViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

class NotFeaturedArtPieceViewController: UIViewController {

    // MARK: - Properties

    weak var delegate: ArtPieceViewControllerDelegate?
    
    var collectionView: UICollectionView?
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurredEffectView = BackgroundVisualEffectView()
        
        self.view.addSubview(blurredEffectView)
        
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurredEffectView.constraint(edgesTo: view)

        setupCollectionView()
        
        guard let collectionView = self.collectionView else { return }
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.constraint(edgesTo: view)
    }
    
    // MARK: - View setup
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(NotFeaturedArtPieceCollectionViewCell.self, forCellWithReuseIdentifier: NotFeaturedArtPieceCollectionViewCell.identifier)
        collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.remembersLastFocusedIndexPath = true
        
        collectionView.selectCell(at: collectionView.firstCellIndex)
    }
}
