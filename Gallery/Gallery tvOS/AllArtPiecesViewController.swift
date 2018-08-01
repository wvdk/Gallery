//
//  AllArtPiecesViewController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class AllArtPiecesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let featuredArtPiecesViewController = FeaturedArtPieceViewController()
        let notFeaturedArtPiecesViewController = FeaturedArtPieceViewController()
        notFeaturedArtPiecesViewController.view.backgroundColor = .black
        
        addChildViewController(featuredArtPiecesViewController)
        view.addSubview(featuredArtPiecesViewController.view)
        
        addChildViewController(notFeaturedArtPiecesViewController)
        view.addSubview(notFeaturedArtPiecesViewController.view)
        
        featuredArtPiecesViewController.view.translatesAutoresizingMaskIntoConstraints = false
        notFeaturedArtPiecesViewController.view.translatesAutoresizingMaskIntoConstraints = false

        featuredArtPiecesViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        featuredArtPiecesViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        featuredArtPiecesViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        featuredArtPiecesViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true

        notFeaturedArtPiecesViewController.view.topAnchor.constraint(equalTo: featuredArtPiecesViewController.view.bottomAnchor).isActive = true
        notFeaturedArtPiecesViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        notFeaturedArtPiecesViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        notFeaturedArtPiecesViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        featuredArtPiecesViewController.didMove(toParentViewController: self)
        notFeaturedArtPiecesViewController.didMove(toParentViewController: self)
    }
}
