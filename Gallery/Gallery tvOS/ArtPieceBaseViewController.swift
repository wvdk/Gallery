//
//  ArtPieceBaseViewController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

/// A container type `UIViewController` with two controllers nested inside:
///
/// 1. Premium art piece collection controller - `FeaturedArtPieceViewController`
/// 2. Free art piece collection controller - `GridArtPieceViewController`
class ArtPieceBaseViewController: UIViewController {

    // MARK: - Properties
    
    var artPieceDisplayController: ArtPieceDisplayViewController?
    
    private let featuredArtPieceViewController = FeaturedArtPieceViewController()
    private let gridArtPieceViewController = GridArtPieceViewController()
    private let headerView = UIView()

    /// Focus guide to set preferred focus environment.
    ///
    /// It is set to featured art piece collection view selected cell during transition from `artPieceCollectionGridViewController` to `featuredArtPieceCollectionViewController`.
    private var gridArtPieceViewControllerFocusGuide = UIFocusGuide()
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 8, g: 127, b: 255)
        
        let center = CGPoint(x: 0.84 * view.bounds.width, y: -0.03 * view.bounds.height)
        let radius = sqrt(pow(view.bounds.size.height, 2) + pow(view.bounds.size.width, 2))
        let colors = [UIColor(r: 0, g: 31, b: 65, alpha: 1).cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        let locations: [CGFloat] = [0, 0.6, 1]
        
        let gradientLayer = RadialGradientLayer(startCenter: center, endCenter: center, startRadius: 0, endRadius: radius, colors: colors, locations: locations)
        gradientLayer.frame = view.bounds
        gradientLayer.opacity = 0.7
        
        view.layer.addSublayer(gradientLayer)
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 40)
        headerLabel.textColor = UIColor.white
        headerLabel.shadowOffset = CGSize(width: 0, height: 1)
        headerLabel.shadowColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.2)
        headerLabel.text = "Gallery of Generative Art"
        
        view.addSubview(headerView)
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        
        featuredArtPieceViewController.delegate = self
        gridArtPieceViewController.delegate = self
        
        addChild(featuredArtPieceViewController)
        addChild(gridArtPieceViewController)
        
        view.addSubview(featuredArtPieceViewController.view)
        view.addSubview(gridArtPieceViewController.view)
      
        makeConstraints()
    }
    
    private func makeConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        featuredArtPieceViewController.view.translatesAutoresizingMaskIntoConstraints = false
        gridArtPieceViewController.view.translatesAutoresizingMaskIntoConstraints = false

        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        featuredArtPieceViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        featuredArtPieceViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        featuredArtPieceViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        featuredArtPieceViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140).isActive = true
        
        gridArtPieceViewController.view.topAnchor.constraint(equalTo: featuredArtPieceViewController.view.bottomAnchor).isActive = true
        gridArtPieceViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        gridArtPieceViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        gridArtPieceViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        featuredArtPieceViewController.didMove(toParent: self)
        gridArtPieceViewController.didMove(toParent: self)
        
        gridArtPieceViewController.view.addLayoutGuide(gridArtPieceViewControllerFocusGuide)
        
        gridArtPieceViewControllerFocusGuide.topAnchor.constraint(equalTo: gridArtPieceViewController.view.topAnchor).isActive = true
        gridArtPieceViewControllerFocusGuide.leadingAnchor.constraint(equalTo: gridArtPieceViewController.view.leadingAnchor).isActive = true
        gridArtPieceViewControllerFocusGuide.trailingAnchor.constraint(equalTo: gridArtPieceViewController.view.trailingAnchor).isActive = true
        gridArtPieceViewControllerFocusGuide.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    // MARK: - Animations
    
    private func slideContentUp() {
        featuredArtPieceViewController.view.transform = CGAffineTransform.identity
        gridArtPieceViewController.view.transform = CGAffineTransform.identity
        headerView.transform = CGAffineTransform.identity
    }
    
    private func slideContentDown() {
        let translationY = featuredArtPieceViewController.view.bounds.size.height + 140
        featuredArtPieceViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
        gridArtPieceViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
        headerView.transform = CGAffineTransform(translationX: 0, y: -translationY)
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let nextFocusedView = context.nextFocusedView, let previouslyFocusedView = context.previouslyFocusedView else { return }
        
        // Returns if previous and next focused views are in the same featuredArtPiecesViewController.
        if featuredArtPieceViewController.contains(previouslyFocusedView), featuredArtPieceViewController.contains(nextFocusedView) {
            return
        }
        
        // Returns if previous and next focused views are in the same notFeaturedArtPiecesViewController.
        if gridArtPieceViewController.contains(previouslyFocusedView), gridArtPieceViewController.contains(nextFocusedView) {
            return
        }
        
        // Animates translation transform between view controllers.
        if gridArtPieceViewController.contains(previouslyFocusedView) {
            // Sets preferred focus guide to default.
            gridArtPieceViewControllerFocusGuide.preferredFocusEnvironments = []
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.slideContentUp()
                }, completion: nil)
            
            return
        }
        
        // Animates translation transform between view controllers.
        if featuredArtPieceViewController.contains(previouslyFocusedView), gridArtPieceViewController.contains(nextFocusedView) {
            // Sets preferred focus guide to `previouslyFocusedView`, so coming back to controller would focus last selected item.
            gridArtPieceViewControllerFocusGuide.preferredFocusEnvironments = [previouslyFocusedView]
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.slideContentDown()
                }, completion: nil)
            
            return
        }
    }
}
