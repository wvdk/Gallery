//
//  FeaturedArtPieceCollectionViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/31/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UIViewController` which contains a featured art piece collection view.
class FeaturedArtPieceCollectionViewController: UIViewController {
   
    // MARK: - Properties
    
    /// The object that acts as the delegate of the `ArtPieceCollectionViewControllerDelegate`.
    weak var delegate: ArtPieceCollectionViewControllerDelegate?
    
    /// Sets up `UICollectionView` with horizontal scrolling direction.
    private var verticalFlowCollectionView: UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        collectionView.register(ArtPieceCollectionViewCell.self, forCellWithReuseIdentifier: ArtPieceCollectionViewCell.identifier)
        collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
        collectionView.remembersLastFocusedIndexPath = true
        collectionView.selectCell(at: collectionView.firstCellIndex)
        
        return collectionView
    }
    
    /// Sets up header which consist of title "Gallery of Generative Art".
    private var headerView: UIView {
        let headerLabel = HeadlineLabel(isFontBold: false)
        headerLabel.text = "Gallery of Generative Art"
        
        let headerContainerView = UIView()
        headerContainerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        
        return headerContainerView
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let header = headerView
        view.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        header.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 140).isActive = true

        let collectionView = verticalFlowCollectionView
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
