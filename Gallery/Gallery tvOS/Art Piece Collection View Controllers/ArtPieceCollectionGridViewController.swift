//
//  ArtPieceCollectionGridViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UIViewController` which contains all art piece grid-like collection view with a vertical scrolling direction.
class ArtPieceCollectionGridViewController: UIViewController {

    // MARK: - Properties

    /// The object that acts as the delegate of the `ArtPieceCollectionViewControllerDelegate`.
    weak var delegate: ArtPieceCollectionViewControllerDelegate?
    
    /// Sets up `UICollectionView` with vertical scrolling direction.
    private var gridCollectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        collectionView.register(ArtPieceCollectionViewCell.self, forCellWithReuseIdentifier: ArtPieceCollectionViewCell.identifier)
        collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.remembersLastFocusedIndexPath = true
        
        return collectionView
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionView = gridCollectionView
        view.addSubview(collectionView)
        collectionView.constraint(edgesTo: view)
    }
}
