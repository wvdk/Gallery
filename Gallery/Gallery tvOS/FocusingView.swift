//
//  FocusingView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 7/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

class FocusingView: UIView {
    
    // MARK: - Properties
    
    private let containerView = UIView()
    
    private var parralaxMotionEffect: UIMotionEffectGroup?
    
    // MARK: - UIView properties
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        self.addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    func addSubview(artPieceView: ArtView) {
        containerView.addSubview(artPieceView)
        
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        
        artPieceView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        artPieceView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        artPieceView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        artPieceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    // MARK: - Focus updates
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView as? FocusingView != nil {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.setFocusedStyle()
                self?.addParallaxMotionEffect()
            }, completion: nil)
        }
        
        if context.previouslyFocusedView as? FocusingView != nil {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                self?.resetFocusedStyle()
                self?.removeParallaxMotionEffect()
            }, completion: nil)
        }
    }
    
    // MARK: - Focus appearance
    
    private func setFocusedStyle() {
        self.transform = CGAffineTransform(scaleX: 1.07, y: 1.07)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 25)
    }
    
    private func resetFocusedStyle() {
        self.transform = CGAffineTransform.identity
        
        self.layer.shadowOpacity = 0
    }
    
    func addParallaxMotionEffect(tiltValue: CGFloat = 0.1, panValue: CGFloat = 8) {
        var xTilt = UIInterpolatingMotionEffect()
        var yTilt = UIInterpolatingMotionEffect()
        var xPan = UIInterpolatingMotionEffect()
        var yPan = UIInterpolatingMotionEffect()
        
        yTilt = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.y", type: .tiltAlongHorizontalAxis)
        yTilt.minimumRelativeValue = -tiltValue
        yTilt.maximumRelativeValue = tiltValue
        
        xTilt = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongVerticalAxis)
        xTilt.minimumRelativeValue = -tiltValue
        xTilt.maximumRelativeValue = tiltValue
        
        xPan = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xPan.minimumRelativeValue = -panValue
        xPan.maximumRelativeValue = panValue

        yPan = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yPan.minimumRelativeValue = -panValue
        yPan.maximumRelativeValue = panValue
        
        if parralaxMotionEffect == nil {
            parralaxMotionEffect = UIMotionEffectGroup()
        }
        
        guard let parralaxMotionEffect = parralaxMotionEffect else { return }
        parralaxMotionEffect.motionEffects = [xTilt, yTilt, xPan, yPan]
        self.addMotionEffect(parralaxMotionEffect)
    }
    
    func removeParallaxMotionEffect() {
        guard let parralaxMotionEffect = parralaxMotionEffect else { return }
        self.removeMotionEffect(parralaxMotionEffect)
    }
}
