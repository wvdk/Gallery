//
//  FeaturedArtPieceViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/31/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class FeaturedArtPieceViewController: UIViewController {
   
    // MARK: - Properties
    
    lazy var collectionViewTopConstrain = 112 / 1080 * self.view.frame.size.height
    lazy var collectionViewBottomConstrain = 140 / 1080 * self.view.frame.size.height
    lazy var collectionViewHeightConstrain = 827 / 1080 * self.view.frame.size.height
    lazy var collectionViewCellWidthConstrain = 1458 / 1920 * self.view.frame.size.width
    lazy var collectionViewLeftEdgeInset = (self.view.frame.size.width - collectionViewCellWidthConstrain) / 2
    
    var collectionView: UICollectionView?
    
    let headerView = UIView()
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        let headerView = setupHeaderView()
        
        guard let collectionView = self.collectionView else { return }
        
        self.view.addSubview(collectionView)
        self.view.addSubview(headerView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: collectionViewTopConstrain).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    // MARK: - View setup
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.register(FeaturedArtPieceCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedArtPieceCollectionViewCell.identifier)
        collectionView.decelerationRate = UIScrollViewDecelerationRateNormal
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.isScrollEnabled = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false

        collectionView.remembersLastFocusedIndexPath = true
        
        collectionView.selectCell(at: collectionView.firstCellIndex)
    }
    
    private func setupHeaderView() -> UIView {
        let headerLabel = HeadlineLabel(isFontBold: false)
        headerLabel.text = "Premium"
        
        let separatorView = UIView()
        separatorView.backgroundColor = .gray
        
        let headerContainerView = UIView()
        
        headerContainerView.addSubview(headerLabel)
        headerContainerView.addSubview(separatorView)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: 180).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -180).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        headerLabel.leadingAnchor.constraint(equalTo: separatorView.leadingAnchor).isActive = true
        headerLabel.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -10).isActive = true
        
        return headerContainerView
    }
}
