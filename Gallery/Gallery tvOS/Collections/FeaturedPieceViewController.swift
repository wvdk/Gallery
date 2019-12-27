//
//  FeaturedPieceViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/31/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UIViewController` which contains a featured art piece collection view with a horizontal scrolling direction.
class FeaturedPieceViewController: UIViewController {
   
    // MARK: - Properties
    
    /// The object that acts as the delegate of the `PieceViewControllerDelegate`.
    weak var delegate: PieceViewControllerDelegate? = nil
    
    /// Sets up `UICollectionView` with horizontal scrolling direction.
    private var verticalFlowCollectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PieceViewCell.self, forCellWithReuseIdentifier: PieceViewCell.identifier)
        collectionView.decelerationRate = UIScrollView.DecelerationRate.normal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.remembersLastFocusedIndexPath = true
        collectionView.selectCell(at: collectionView.firstCellIndex)
        
        return collectionView
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let collectionView = verticalFlowCollectionView
        view.addSubview(collectionView)
        collectionView.constraint(edgesTo: view)
    }
}
