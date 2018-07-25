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
    
    let collectionViewCellIdentifier = "collectionCell"

    var collectionView: UICollectionView?
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()

        guard let collectionView = self.collectionView else { return }
        
        self.view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 113).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -140).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let menuTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.back))
        menuTapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)];
        view.addGestureRecognizer(menuTapRecognizer)
    }
    
    // MARK: - Collection view setup
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellIdentifier)
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.backgroundColor = .black
    }
    
    // MARK: - App control
    
    /// Close the App.
    @objc func back() {
        exit(EXIT_SUCCESS)
    }
}

