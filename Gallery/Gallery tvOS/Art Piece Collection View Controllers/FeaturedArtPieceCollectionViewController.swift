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
    
    /// Returns tag id integer number for rotating line superview.
    private let rotatingLineViewTag = 10928
    
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
    private lazy var headerView: UIView = {
        let headerContainerView = UIView()

        let lineView = rotatingLineView
        lineView.tag = rotatingLineViewTag
        headerContainerView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor, constant: view.frame.size.width * 300 / 1920).isActive = true
        lineView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: view.frame.size.width * 280 / 1920).isActive = true
        lineView.topAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        lineView.bottomAnchor.constraint(equalTo: headerContainerView.topAnchor, constant: view.frame.size.height * 200 / 1119).isActive = true
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 40)
        headerLabel.textColor = UIColor(r: 173, g: 173, b: 173, alpha: 0.5)
        headerLabel.text = "Gallery of Generative Art"
        headerLabel.shadowColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.1)
        headerLabel.shadowOffset = CGSize(width: 0, height: 2)
        headerContainerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerYAnchor.constraint(equalTo: headerContainerView.centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        
        return headerContainerView
    }()
    
    /// Sets up rotating line view of 60 duplicates.
    private var rotatingLineView: UIView {
        let view = UIView()
        
        let line = UIView(frame: CGRect(x: 0, y: 0, width: 3, height: 500))
        view.addSubview(line)
        
        line.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        line.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
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
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 140).isActive = true

        let collectionView = verticalFlowCollectionView
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let lineView = headerView.subviews.first(where: { $0.tag == rotatingLineViewTag }) {
            for subview in lineView.subviews {
                subview.rotate(duration: 30.0)
            }
        }
    }
}
