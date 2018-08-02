//
//  AllArtPiecesViewController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class AllArtPiecesViewController: UIViewController {

    // MARK: - Properties
    
    private let featuredArtPiecesViewController = FeaturedArtPieceViewController()
    private let notFeaturedArtPiecesViewController = NotFeaturedArtPieceViewController()
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        notFeaturedArtPiecesViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        featuredArtPiecesViewController.didMove(toParentViewController: self)
        notFeaturedArtPiecesViewController.didMove(toParentViewController: self)
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let nextFocusedView = context.nextFocusedView, let previouslyFocusedView = context.previouslyFocusedView else { return }
        
        if nextFocusedView.superview == previouslyFocusedView.superview {
            return
        }
        
        if notFeaturedArtPiecesViewController.contains(previouslyFocusedView)  {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.featuredArtPiecesViewController.view.transform = CGAffineTransform.identity
                self?.notFeaturedArtPiecesViewController.view.transform = CGAffineTransform.identity
                }, completion: nil)
            
            return
        }
        
        if featuredArtPiecesViewController.contains(previouslyFocusedView), notFeaturedArtPiecesViewController.contains(nextFocusedView) {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                guard let translationY = self?.featuredArtPiecesViewController.view.bounds.size.height else { return }
                self?.featuredArtPiecesViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
                self?.notFeaturedArtPiecesViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
                }, completion: nil)
            
            return
        }
    }
}
