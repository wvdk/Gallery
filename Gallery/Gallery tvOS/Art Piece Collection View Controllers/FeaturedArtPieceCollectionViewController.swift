//
//  FeaturedArtPieceCollectionViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/31/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UIViewController` which contains a featured art piece collection view with a horizontal scrolling direction.
class FeaturedArtPieceCollectionViewController: UIViewController {
   
    // MARK: - Properties
    
    /// The object that acts as the delegate of the `ArtPieceCollectionViewControllerDelegate`.
    weak var delegate: ArtPieceCollectionViewControllerDelegate? = nil
    
    /// Sets up rotating line view of 60 duplicates.
    private var rotatingLineView: UIView {
        let view = UIView()
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 250))
        view.addSubview(line)
        
        line.layer.shadowOffset = CGSize(width: 1, height: 1)
        line.layer.shadowColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.5).cgColor
        
        line.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        line.backgroundColor = UIColor(r: 173, g: 173, b: 173, alpha: 0.65)
        line.alpha = 0.05
        
        line.loopInSuperview(duplicationCount: 60, with: [
            .rotateByDegrees(-0.06),
            .moveHorizontallyWithIncrement(30),
            .updateOpacityIncreasingly
            ]
        )
        
        for subview in view.subviews {
            subview.rotate(duration: 50.0)
        }
        
        return view
    }
    
    /// Sets up header which consist of title "Gallery of Generative Art" and rotating lines.
    private var headerView: UIView {
        let headerContainerView = UIView()
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 35)
        headerLabel.textColor = UIColor(r: 173, g: 173, b: 173, alpha: 0.5)
        headerLabel.text = "Gallery of Generative Art"
        headerContainerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        
        let lineView = rotatingLineView
        headerContainerView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: view.frame.size.width * 300 / 1920).isActive = true
        lineView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: view.frame.size.width * 280 / 1920).isActive = true
        lineView.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        lineView.bottomAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: view.frame.size.height * 200 / 1119).isActive = true
        
        return headerContainerView
    }
    
    /// Sets up `UICollectionView` with a horizontal scrolling direction.
    private var collectionView: DisabledFocusCollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = DisabledFocusCollectionView(frame: view.frame, collectionViewLayout: layout)
        
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

        let collection = collectionView
        view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        collection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
