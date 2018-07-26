//
//  MainViewController.swift
//  GalleryTV
//
//  Created by Kristina Gelzinyte on 6/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

class MainViewController: UIViewController {

    // MARK: - Properties

    lazy var collectionViewTopConstrain = 113 / 1080 * self.view.frame.size.height
    lazy var collectionViewBottomConstrain = 140 / 1080 * self.view.frame.size.height
    lazy var collectionViewHeightConstrain = 827 / 1080 * self.view.frame.size.height
    lazy var collectionViewCellWidthConstrain = 1458 / 1920 * self.view.frame.size.width
    lazy var collectionViewLeftEdgeInset = (self.view.frame.size.width - collectionViewCellWidthConstrain) / 2

    var collectionView: UICollectionView?
    
    //    override var preferredFocusEnvironments: [UIFocusEnvironment] {
    //        guard let collectionView = collectionView else {
    //            return []
    //        }
    //        return [collectionView]
    //    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()

        guard let collectionView = self.collectionView else { return }
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: collectionViewTopConstrain).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -collectionViewBottomConstrain).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
//        let menuTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.back))
//        menuTapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)];
//        view.addGestureRecognizer(menuTapRecognizer)
    }
    
    // MARK: - Collection view setup
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(ArtPieceCollectionViewCell.self, forCellWithReuseIdentifier: ArtPieceCollectionViewCell.identifier)
        collectionView?.decelerationRate = UIScrollViewDecelerationRateNormal
        collectionView?.delegate = self
        collectionView?.dataSource = self
                
        collectionView?.isScrollEnabled = false
        collectionView?.allowsSelection = true
        collectionView?.allowsMultipleSelection = false
        
//        collectionView?.backgroundColor = .black
    }
    
    // MARK: - App control

}
