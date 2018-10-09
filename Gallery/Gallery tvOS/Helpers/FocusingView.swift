//
//  FocusingView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 7/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UIView` which can become focused when system updates the focus for views.
///
/// In focused mode implements parallax effect.
///
/// Should set `thumbnail` image.
///
/// Can add subview to this view which can be animated.
class FocusingView: UIView {
    
    // MARK: - Properties
    
    /// An art piece type to be presented in receiver's view.
    var artViewType: UIView.Type? = nil
    
    /// Thumbnail image of the art piece to be shown in receiver'v view.
    var thumbnail: UIImage? = nil {
        didSet {
            thumbnailView.image = thumbnail ?? UIImage(named: "defaultThumbnail")
            thumbnailView.contentMode = .scaleAspectFill
        }
    }
    
    private var artPieceViewParralaxMotionEffect: UIMotionEffectGroup?
    
    private let containerView = UIView()
    private let thumbnailView = UIImageView()
    private var artViewTag = 502934

    // MARK: - UIView properties
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        addSubview(containerView)
        containerView.constraint(edgesTo: self)

        containerView.addSubview(thumbnailView)
        thumbnailView.constraint(edgesTo: containerView)
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        
        setDefaultShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Subview management
    
    /// Adds a specified `UIView` view to the end of the receiver’s list of subviews.
    func showArtView() {
        guard let artViewType = self.artViewType else { return }
        
        let artView = artViewType.init(frame: bounds)
        artView.alpha = 0
        artView.tag = artViewTag
        
        containerView.addSubview(artView)
        artView.constraint(edgesTo: containerView)
        
        UIView.animate(withDuration: 0.2) {
            artView.alpha = 1
        }
    }
    
    /// Fades out and removes a `UIView` type views from the receiver’s list of subviews.
    func removeArtView() {
        let artViews = containerView.subviews.filter({ $0.tag == artViewTag })
        
        artViews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // Animates view's appearance to be focused.
        if let nextFocusedView = context.nextFocusedView as? FocusingView, nextFocusedView == self {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.setFocusedStyleShadow()
                
                }, completion: { [weak self] in
                    self?.addParallaxMotionEffect()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                        self?.showArtView()
                    })
            })
        }
        
        // Animates view's appearance to be not focused.
        if let previouslyFocusedView = context.previouslyFocusedView as? FocusingView, previouslyFocusedView == self {
            removeParallaxMotionEffect()
            removeArtView()
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                self?.setDefaultShadow()
                
                UIView.animate(withDuration: animationContext.duration * 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self?.transformScale(to: 1)
                })
                
                }, completion: nil)
        }
    }
    
    // MARK: - Focus appearance
    
    /// Transforms scale to specified value.
    func transformScale(to value: CGFloat) {
        transform = CGAffineTransform(scaleX: value, y: value)
    }
    
    /// Sets focus style to the view:
    /// - Scales by 1.07.
    /// - Adds significant drop down shadow to the view's layer.
    private func setFocusedStyleShadow() {
        layer.shadowRadius = 15
        layer.shadowOffset = CGSize(width: 0, height: 25)
    }
    
    /// Adds small drop down type shadow to the view's layer.
    private func setDefaultShadow() {
        layer.shadowColor = UIColor.black.cgColor

        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    /// Adds parallax motion effect to the `view`, which allows to pan and tilt it.
    /// - Parameters:
    ///     - tiltValue: View's maximum tilt value in radians, by default it is 0.1.
    ///     - panValue: View's maximum pan value in points, by default it is 8.
    private func addParallaxMotionEffect(tiltValue: CGFloat = 0.15, panValue: CGFloat = 30) {
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
        
        addMotionEffect(parralaxMotionEffect)
    }
    
    /// Removes parallax motion effect from the `view`.
    private func removeParallaxMotionEffect() {
        guard let artPieceViewParralaxMotionEffect = self.artPieceViewParralaxMotionEffect else { return }
        removeMotionEffect(artPieceViewParralaxMotionEffect)
        
        self.artPieceViewParralaxMotionEffect = nil
    }
}
