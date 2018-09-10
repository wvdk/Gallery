//
//  ArtPieceContainerViewController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A container type `UIViewController` with two controllers nested inside:
///
/// 1. Premium art piece collection controller - `FeaturedArtPieceViewController`
/// 2. Free art piece collection controller - `NotFeaturedArtPieceViewController`
class ArtPieceContainerViewController: UIViewController {

    // MARK: - Properties
    
    var artPieceDetailController: ArtPieceDisplayViewController?
    
    private let featuredArtPieceCollectionViewController = FeaturedArtPieceCollectionViewController()
    private let artPieceCollectionGridViewController = ArtPieceCollectionGridViewController()
    
    /// Focus guide to set preferred focus environment.
    ///
    /// It is set to featured art piece collection view selected cell during transition from `artPieceCollectionGridViewController` to `featuredArtPieceCollectionViewController`.
    private var artPieceCollectionGridViewControllerFocusGuide = UIFocusGuide()
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundLayer()
        
        featuredArtPieceCollectionViewController.delegate = self
        artPieceCollectionGridViewController.delegate = self

        addChildViewController(featuredArtPieceCollectionViewController)
        view.addSubview(featuredArtPieceCollectionViewController.view)

        addChildViewController(artPieceCollectionGridViewController)
        view.addSubview(artPieceCollectionGridViewController.view)

        featuredArtPieceCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        artPieceCollectionGridViewController.view.translatesAutoresizingMaskIntoConstraints = false

        featuredArtPieceCollectionViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        featuredArtPieceCollectionViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        featuredArtPieceCollectionViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        featuredArtPieceCollectionViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true

        artPieceCollectionGridViewController.view.topAnchor.constraint(equalTo: featuredArtPieceCollectionViewController.view.bottomAnchor).isActive = true
        artPieceCollectionGridViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        artPieceCollectionGridViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        artPieceCollectionGridViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true

        featuredArtPieceCollectionViewController.didMove(toParentViewController: self)
        artPieceCollectionGridViewController.didMove(toParentViewController: self)

        artPieceCollectionGridViewController.view.addLayoutGuide(artPieceCollectionGridViewControllerFocusGuide)

        artPieceCollectionGridViewControllerFocusGuide.topAnchor.constraint(equalTo: artPieceCollectionGridViewController.view.topAnchor).isActive = true
        artPieceCollectionGridViewControllerFocusGuide.leadingAnchor.constraint(equalTo: artPieceCollectionGridViewController.view.leadingAnchor).isActive = true
        artPieceCollectionGridViewControllerFocusGuide.trailingAnchor.constraint(equalTo: artPieceCollectionGridViewController.view.trailingAnchor).isActive = true
        artPieceCollectionGridViewControllerFocusGuide.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: - Background setup
    
    private func setupBackgroundLayer() {
        view.backgroundColor = .white
        
        let linearGradient = CAGradientLayer()
        view.layer.addSublayer(linearGradient)
        linearGradient.frame = view.bounds
        linearGradient.colors = [
            UIColor(r: 146, g: 232, b: 201, alpha: 0.11).cgColor,
            UIColor(r: 31, g: 50, b: 43, alpha: 0.65).cgColor,
            UIColor(r: 0, g: 0, b: 0, alpha: 1.0).cgColor
        ]
        linearGradient.locations = [
            NSNumber(value: 0),
            NSNumber(value: 1 - 950 / 1119),
            NSNumber(value: 1 - 1082 / 1119)
        ]

        let radialGradient = RadialGradientLayer()
        view.layer.addSublayer(radialGradient)
        radialGradient.frame = view.bounds
        radialGradient.opacity = 0.2
        radialGradient.radius = view.frame.size.height * 790 / 1119
        radialGradient.colors = [
            UIColor(r: 126, g: 251, b: 248, alpha: 1),
            UIColor(r: 255, g: 255, b: 255, alpha: 0)
        ]
        
        let diagonalGradient = CAGradientLayer()
        view.layer.addSublayer(diagonalGradient)
        diagonalGradient.frame = view.bounds
        diagonalGradient.opacity = 0.2
        diagonalGradient.startPoint = CGPoint(x: 1, y: 0)
        diagonalGradient.endPoint = CGPoint(x: 0, y: 1)
        diagonalGradient.colors = [
            UIColor(r: 255, g: 255, b: 255, alpha: 1).cgColor,
            UIColor(r: 31, g: 50, b: 43, alpha: 1).cgColor
        ]
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let nextFocusedView = context.nextFocusedView, let previouslyFocusedView = context.previouslyFocusedView else { return }
        
        // Returns if previous and next focused views are in the same featuredArtPiecesViewController.
        if featuredArtPieceCollectionViewController.contains(previouslyFocusedView), featuredArtPieceCollectionViewController.contains(nextFocusedView) {
            return
        }
        
        // Returns if previous and next focused views are in the same notFeaturedArtPiecesViewController.
        if artPieceCollectionGridViewController.contains(previouslyFocusedView), artPieceCollectionGridViewController.contains(nextFocusedView) {
            return
        }
        
        // Animates translation transform between view controllers.
        if artPieceCollectionGridViewController.contains(previouslyFocusedView) {
            // Sets preferred focus guide to default.
            artPieceCollectionGridViewControllerFocusGuide.preferredFocusEnvironments = []
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.featuredArtPieceCollectionViewController.view.transform = CGAffineTransform.identity
                self?.artPieceCollectionGridViewController.view.transform = CGAffineTransform.identity
                }, completion: nil)
            
            return
        }
        
        // Animates translation transform between view controllers.
        if featuredArtPieceCollectionViewController.contains(previouslyFocusedView), artPieceCollectionGridViewController.contains(nextFocusedView) {
            
            // Sets preferred focus guide to `previouslyFocusedView`, so coming back to controller would focus last selected item.
            artPieceCollectionGridViewControllerFocusGuide.preferredFocusEnvironments = [previouslyFocusedView]
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                guard let translationY = self?.featuredArtPieceCollectionViewController.view.bounds.size.height else { return }
                self?.featuredArtPieceCollectionViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
                self?.artPieceCollectionGridViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
                }, completion: nil)
            
            return
        }
    }
}
