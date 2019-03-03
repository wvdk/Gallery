//
//  PieceViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UIViewController` which contains all art piece grid-like collection view with a vertical scrolling direction.
class PieceViewController: UIViewController {

    // MARK: - Properties

    /// The object that acts as the delegate of the `PieceViewControllerDelegate`.
    weak var delegate: PieceViewControllerDelegate?
    
    /// Sets up `UICollectionView` with vertical scrolling direction.
    private var gridCollectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = view.frame.size.width * 0.0188
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        collectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.identifier)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
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
