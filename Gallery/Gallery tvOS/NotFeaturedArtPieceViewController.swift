//
//  NotFeaturedArtPieceViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class NotFeaturedArtPieceViewController: UIViewController {

    // MARK: - Properties

    var collectionView: UICollectionView?
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blurredEffectView = BackgroundVisualEffectView()

        setupCollectionView()
        
        guard let collectionView = self.collectionView else { return }
        
        self.view.addSubview(blurredEffectView)
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        blurredEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        blurredEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        blurredEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        blurredEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
        
//        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.remembersLastFocusedIndexPath = true
        
        collectionView.selectCell(at: collectionView.firstCellIndex)
    }
}
