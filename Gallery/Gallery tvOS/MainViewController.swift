//
//  MainViewController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

/// A container type `UIViewController` with two controllers nested inside:
///
/// 1. Premium art piece collection controller - `FeaturedPieceViewController`
/// 2. Free art piece collection controller - `PieceViewController`
class MainViewController: UIViewController {

    // MARK: - Properties
    
    var pieceDisplayController: PieceDisplayViewController?
    
    private let featuredPieceViewController = FeaturedPieceViewController()
    private let pieceViewController = PieceViewController()
    private let headerView = UIView()
    private let backgroundView = UIView()
    private let bottomBackgroundView = UIView()

    /// Focus guide to set preferred focus environment.
    ///
    /// It is set to featured art piece collection view selected cell during transition from `pieceViewController` to `featuredPieceViewController`.
    private var pieceViewControllerFocusGuide = UIFocusGuide()
    
    // MARK: - Lifecycle functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 8, g: 127, b: 255)
        
        let center = CGPoint(x: 0.84 * view.bounds.width, y: -0.03 * view.bounds.height)
        let radius = sqrt(pow(view.bounds.size.height * 2, 2) + pow(view.bounds.size.width, 2))
        let colors = [UIColor(r: 0, g: 31, b: 65, alpha: 1).cgColor, UIColor.black.cgColor, UIColor.black.cgColor]
        let locations: [CGFloat] = [0, 0.3, 1]
        
        let topLayer = RadialGradientLayer(startCenter: center, endCenter: center, startRadius: 0, endRadius: radius, colors: colors, locations: locations)
        topLayer.frame = CGRect(origin: view.frame.origin, size: CGSize(width: view.bounds.size.width, height: view.bounds.size.height * 2))
        topLayer.opacity = 0.7
        
        backgroundView.layer.addSublayer(topLayer)
        
        bottomBackgroundView.layer.cornerRadius = 10
        bottomBackgroundView.layer.backgroundColor = UIColor.white.withAlphaComponent(0.25).cgColor
        
        let headerLabel = UILabel()
        headerLabel.font = UIFont.systemFont(ofSize: 40)
        headerLabel.textColor = UIColor.white
        headerLabel.shadowOffset = CGSize(width: 0, height: 1)
        headerLabel.shadowColor = UIColor(r: 0, g: 0, b: 0, alpha: 0.2)
        headerLabel.text = "Gallery of Generative Art"
        
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        
        backgroundView.addSubview(bottomBackgroundView)
        headerView.addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -view.frame.size.height * 0.045).isActive = true
        
        featuredPieceViewController.delegate = self
        pieceViewController.delegate = self
        
        addChild(featuredPieceViewController)
        addChild(pieceViewController)
        
        view.addSubview(featuredPieceViewController.view)
        view.addSubview(pieceViewController.view)
      
        makeConstraints()
    }
    
    private func makeConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        bottomBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        featuredPieceViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pieceViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalEdgeInset = 0.13 * view.frame.size.height
        
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: verticalEdgeInset).isActive = true
        
        featuredPieceViewController.view.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        featuredPieceViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        featuredPieceViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        featuredPieceViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -verticalEdgeInset).isActive = true
        
        backgroundView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: pieceViewController.view.bottomAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: featuredPieceViewController.view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: featuredPieceViewController.view.trailingAnchor).isActive = true

        pieceViewController.view.topAnchor.constraint(equalTo: featuredPieceViewController.view.bottomAnchor).isActive = true
        pieceViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pieceViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        pieceViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        bottomBackgroundView.constraint(edgesTo: pieceViewController.view, constant: 0.019 * view.frame.size.width)
        
        featuredPieceViewController.didMove(toParent: self)
        pieceViewController.didMove(toParent: self)
        
        pieceViewController.view.addLayoutGuide(pieceViewControllerFocusGuide)
        
        pieceViewControllerFocusGuide.topAnchor.constraint(equalTo: pieceViewController.view.topAnchor).isActive = true
        pieceViewControllerFocusGuide.leadingAnchor.constraint(equalTo: pieceViewController.view.leadingAnchor).isActive = true
        pieceViewControllerFocusGuide.trailingAnchor.constraint(equalTo: pieceViewController.view.trailingAnchor).isActive = true
        pieceViewControllerFocusGuide.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // MARK: - Animations
    
    private func slideContentUp() {
        featuredPieceViewController.view.transform = .identity
        pieceViewController.view.transform = .identity
        headerView.transform = .identity
        backgroundView.transform = .identity
    }
    
    private func slideContentDown() {
        let translationY = featuredPieceViewController.view.bounds.size.height + 0.13 * view.frame.size.height
        featuredPieceViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
        pieceViewController.view.transform = CGAffineTransform(translationX: 0, y: -translationY)
        headerView.transform = CGAffineTransform(translationX: 0, y: -translationY)
        backgroundView.transform = CGAffineTransform(translationX: 0, y: -translationY)
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let nextFocusedView = context.nextFocusedView, let previouslyFocusedView = context.previouslyFocusedView else {
            return
        }
        
        // Returns if previous and next focused views are in the same featuredPieceViewController.
        if featuredPieceViewController.contains(previouslyFocusedView), featuredPieceViewController.contains(nextFocusedView) {
            return
        }
        
        // Returns if previous and next focused views are in the same pieceViewController.
        if pieceViewController.contains(previouslyFocusedView), pieceViewController.contains(nextFocusedView) {
            return
        }
        
        // Animates translation transform between view controllers.
        if pieceViewController.contains(previouslyFocusedView) {
            // Sets preferred focus guide to default.
            pieceViewControllerFocusGuide.preferredFocusEnvironments = []
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.slideContentUp()
                
                UIView.animate(withDuration: animator.duration / 4, animations: {
                    self?.bottomBackgroundView.transform = .identity
                    self?.bottomBackgroundView.alpha = 1
                })
            }, completion: nil)
            
            return
        }
        
        // Animates translation transform between view controllers.
        if featuredPieceViewController.contains(previouslyFocusedView), pieceViewController.contains(nextFocusedView) {
            // Sets preferred focus guide to `previouslyFocusedView`, so coming back to controller would focus last selected item.
            pieceViewControllerFocusGuide.preferredFocusEnvironments = [previouslyFocusedView]
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animator) in
                self?.slideContentDown()
                
                UIView.animate(withDuration: animator.duration / 8, animations: {
                    self?.bottomBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 0)
                    self?.bottomBackgroundView.alpha = 0
                })
            }, completion: nil)
            
            return
        }
    }
}
