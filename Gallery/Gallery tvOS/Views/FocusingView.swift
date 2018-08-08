//
//  FocusingView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 7/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// `UIView`, which can become focused.
///
/// In focused mode implements parallax effect.
class FocusingView: UIView {
    
    // MARK: - Properties
    
    var delegate: FocusingViewDelegate?
    var thumbnail: UIImage? = nil {
        didSet {
            thumbnailView.image = thumbnail ?? UIImage(named: "defaultThumbnail")
        }
    }
    
    private let containerView = UIView()
    private let thumbnailView = UIImageView()
    
    private var artPieceViewParralaxMotionEffect: UIMotionEffectGroup?

    // MARK: - UIView properties
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        self.addSubview(containerView)
        containerView.addSubview(thumbnailView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.constraint(edgesTo: self)
        thumbnailView.constraint(edgesTo: containerView)
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        
        addDefaultShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    func addSubview(artPieceView: ArtView) {
        containerView.addSubview(artPieceView)
        
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        
        artPieceView.constraint(edgesTo: containerView)
    }
    
    // MARK: - Focus updates
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let nextFocusedView = context.nextFocusedView as? FocusingView, nextFocusedView == self {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                if let strongSelf = self {
                    strongSelf.setFocusedStyle()
                    strongSelf.addParallaxMotionEffect()
                    strongSelf.delegate?.focusingViewDidBecomeFocused(strongSelf)
                }}, completion: nil)
        }
        
        if let previouslyFocusedView = context.previouslyFocusedView as? FocusingView, previouslyFocusedView == self {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                if let strongSelf = self {
                    strongSelf.resetFocusedStyle()
                    strongSelf.removeParallaxMotionEffect()
                    strongSelf.delegate?.focusingViewDidResignedFocus(strongSelf)
                }}, completion: nil)
        }
    }
    
    // MARK: - Focus appearance
    
    private func setFocusedStyle() {
        self.transform = CGAffineTransform(scaleX: 1.07, y: 1.07)

        self.layer.shadowRadius = 15
        self.layer.shadowOffset = CGSize(width: 0, height: 25)
    }
    
    private func resetFocusedStyle() {
        self.transform = CGAffineTransform.identity
        
        addDefaultShadow()
    }
    
    private func addDefaultShadow() {
        self.layer.shadowColor = UIColor.black.cgColor

        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    private func addParallaxMotionEffect(tiltValue: CGFloat = 0.1, panValue: CGFloat = 8) {
        let yTilt = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.y", type: .tiltAlongHorizontalAxis)
        yTilt.minimumRelativeValue = -tiltValue
        yTilt.maximumRelativeValue = tiltValue
        
        let xTilt = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongVerticalAxis)
        xTilt.minimumRelativeValue = -tiltValue
        xTilt.maximumRelativeValue = tiltValue
        
        let xPan = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xPan.minimumRelativeValue = -panValue
        xPan.maximumRelativeValue = panValue

        let yPan = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yPan.minimumRelativeValue = -panValue
        yPan.maximumRelativeValue = panValue
        
        if artPieceViewParralaxMotionEffect == nil {
            artPieceViewParralaxMotionEffect = UIMotionEffectGroup()
        }
        
        guard let parralaxMotionEffect = artPieceViewParralaxMotionEffect else { return }
        parralaxMotionEffect.motionEffects = [xTilt, yTilt, xPan, yPan]
        
        self.addMotionEffect(parralaxMotionEffect)
    }
    
    private func removeParallaxMotionEffect() {
        guard let artPieceViewParralaxMotionEffect = artPieceViewParralaxMotionEffect else { return }
        self.removeMotionEffect(artPieceViewParralaxMotionEffect)
        
        self.artPieceViewParralaxMotionEffect = nil
    }
}

protocol FocusingViewDelegate: class {
    
    func focusingViewDidBecomeFocused(_ focusingView: FocusingView)
    
    func focusingViewDidResignedFocus(_ focusingView: FocusingView)
}
