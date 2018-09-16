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
    
    private let loopingLinesView = LoopingLinesView()
    private let headerView = UIView()
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackgroundLayer()
        setupHeaderView()
        setupCollectionViewControllers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(startLineAnimation), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startLineAnimation()
    }
    
    // MARK: - Background setup
    
    private func setupBackgroundLayer() {
        let background = GradientBackgroundView(frame: view.bounds)
        view.addSubview(background)
    }
    
    private func setupHeaderView() {
        headerView.addSubview(loopingLinesView)
        loopingLinesView.translatesAutoresizingMaskIntoConstraints = false
        loopingLinesView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: view.frame.size.width * 300 / 1920).isActive = true
        loopingLinesView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 40)
        headerLabel.textColor = UIColor(r: 197, g: 218, b: 219, alpha: 1)
        headerLabel.shadowOffset = CGSize(width: 0, height: 1)
        headerLabel.shadowColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.2)
        headerLabel.text = "Gallery of Generative Art"
        
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -view.frame.size.height * 50 / 1119).isActive = true
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 140).isActive = true
    }
    
    private func setupCollectionViewControllers() {
        featuredArtPieceCollectionViewController.delegate = self
        artPieceCollectionGridViewController.delegate = self
        
        addChildViewController(featuredArtPieceCollectionViewController)
        view.addSubview(featuredArtPieceCollectionViewController.view)
        
        addChildViewController(artPieceCollectionGridViewController)
        view.addSubview(artPieceCollectionGridViewController.view)
        
        featuredArtPieceCollectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        artPieceCollectionGridViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        featuredArtPieceCollectionViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
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
    
    // MARK: - Animations
    
    @objc private func startLineAnimation() {
        loopingLinesView.rotate()
    }
    
    private func slideContentUp() {
        featuredArtPieceCollectionViewController.view.transform = CGAffineTransform.identity
        artPieceCollectionGridViewController.view.transform = CGAffineTransform.identity
        headerView.transform = CGAffineTransform.identity
    }
    
    private func slideContentDown() {
        let translationY = featuredArtPieceCollectionViewController.view.bounds.size.height + 140
        featuredArtPieceCollectionViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
        artPieceCollectionGridViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
        headerView.transform = CGAffineTransform(translationX: 0, y: -translationY)
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
                self?.slideContentUp()
                }, completion: nil)
            
            return
        }
        
        // Animates translation transform between view controllers.
        if featuredArtPieceCollectionViewController.contains(previouslyFocusedView), artPieceCollectionGridViewController.contains(nextFocusedView) {
            // Sets preferred focus guide to `previouslyFocusedView`, so coming back to controller would focus last selected item.
            artPieceCollectionGridViewControllerFocusGuide.preferredFocusEnvironments = [previouslyFocusedView]
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.slideContentDown()
                }, completion: nil)
            
            return
        }
    }
}
