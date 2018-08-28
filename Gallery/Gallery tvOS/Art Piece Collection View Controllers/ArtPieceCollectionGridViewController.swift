//
//  ArtPieceCollectionGridViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

class ArtPieceCollectionGridViewController: UIViewController {

    // MARK: - Properties

    /// The object that acts as the delegate of the `ArtPieceCollectionViewControllerDelegate`.
    weak var delegate: ArtPieceCollectionViewControllerDelegate?
    
    var collectionView: UICollectionView?
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets background view to dark `UIVisualEffectView`.
        let blurredEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        view.addSubview(blurredEffectView)
        
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurredEffectView.constraint(edgesTo: view)

        setupCollectionView()
        
        guard let collectionView = self.collectionView else { return }
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.constraint(edgesTo: view)
    }
    
    // MARK: - View setup
    
    /// Sets up `UICollectionView` with vertical scrolling direction.
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(ArtPieceCollectionGridViewCell.self, forCellWithReuseIdentifier: ArtPieceCollectionGridViewCell.identifier)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.remembersLastFocusedIndexPath = true
        
        collectionView.selectCell(at: collectionView.firstCellIndex)
    }
}
