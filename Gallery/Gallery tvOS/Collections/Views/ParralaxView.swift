//
//  ParralaxView.swift
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
class ParralaxView: UIView {
    
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
    
    private var parralaxMotionEffect: UIMotionEffectGroup?
    
    private let containerView: UIView
    private let thumbnailView: UIImageView
    private let innerShadowView: UIView
    private let shadowLayer: CAShapeLayer

    private var artView: UIView?

    private var borderColor: CGColor {
        return isFocused ? UIColor.white.cgColor : UIColor.white.withAlphaComponent(0.7).cgColor
    }
    
    private var shadowOpacity: Float {
        return isFocused ? 0.5 : 0.25
    }
    
    private var shadowOffset: CGSize {
        return isFocused ? CGSize(width: 0, height: 10) : CGSize(width: 0, height: 0)
    }
    
    // MARK: - UIView properties
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        containerView = UIView()
        thumbnailView = UIImageView()
        innerShadowView = UIView()
        shadowLayer = CAShapeLayer()
        
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        layer.cornerRadius = 8
        layer.borderWidth = 4
        layer.shadowRadius = 15
        
        containerView.clipsToBounds = true
        
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = 0.26
        
        innerShadowView.layer.addSublayer(shadowLayer)
        
        addSubview(containerView)
        containerView.addSubview(thumbnailView)
        containerView.addSubview(innerShadowView)

        containerView.constraint(edgesTo: self)
        thumbnailView.constraint(edgesTo: self)
        
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        
        layer.shadowPath = path

        let maskLayer = CAShapeLayer()
        maskLayer.path = path
        
        containerView.layer.mask = maskLayer

        let innerFrame = bounds.insetBy(dx: -4 * 2.0, dy: -4 * 2.0)
        let outerFrame = bounds
        let shadowPath = CGMutablePath()
        
        shadowPath.addRect(innerFrame)
        shadowPath.addRect(outerFrame)
        
        shadowLayer.frame = bounds
        shadowLayer.path = shadowPath
    }
    
    // MARK: - Appearance
    
    private func updateUI() {
        self.layer.borderColor = self.borderColor
        self.layer.shadowOpacity = self.shadowOpacity
        self.layer.shadowOffset = self.shadowOffset
    }
    
    // MARK: - Subview management
    
    /// Adds a specified `UIView` view to the end of the receiver’s list of subviews.
    private func showArtPiece() {
        guard isFocused, let artViewType = self.artViewType else {
            return
        }

        let artView = artViewType.init(frame: bounds)
        artView.alpha = 0

        containerView.insertSubview(artView, belowSubview: innerShadowView)
        artView.constraint(edgesTo: containerView)

        UIView.animate(withDuration: 0.2) {
            artView.alpha = 1
        }

        self.artView = artView
    }
    
    /// Fades out and removes a `UIView` type views from the receiver’s list of subviews.
    private func removeArtPiece() {
        artView?.removeFromSuperview()
        artView = nil
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // Animates view's appearance to be focused.
        if let nextFocusedView = context.nextFocusedView as? ParralaxView, nextFocusedView == self {
            coordinator.addCoordinatedFocusingAnimations({ (animationContext) in
                // TODO: - Animate something
            }, completion: { [weak self] in
                guard let self = self else {
                    return
                }
                
                self.addParallaxMotionEffect()
                self.updateUI()

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: {
                    self.showArtPiece()
                })
            })
        }
        
        // Animates view's appearance to be not focused.
        if let previouslyFocusedView = context.previouslyFocusedView as? ParralaxView, previouslyFocusedView == self {
            removeParallaxMotionEffect()
            removeArtPiece()
            
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                guard let self = self else {
                    return
                }

                UIView.animate(withDuration: animationContext.duration * 0.5, delay: 0, options: .curveEaseOut, animations: {
                    self.transform = CGAffineTransform.identity
                    self.updateUI()
                })
                
            }, completion: nil)
        }
    }
    
    // MARK: - Focus appearance
    
    /// Transforms scale to specified value.
    func transformScale(to value: CGSize) {
        transform = CGAffineTransform(scaleX: value.width, y: value.height)
    }
    
    /// Transforms translation by specified value.
    func transformTranslation(by value: CGPoint) {
        transform = transform.concatenating(CGAffineTransform(translationX: value.x, y: value.y))
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
        
        if parralaxMotionEffect == nil {
            parralaxMotionEffect = UIMotionEffectGroup()
        }
        
        guard let parralaxMotionEffect = parralaxMotionEffect else {
            return
        }
        
        parralaxMotionEffect.motionEffects = [xTilt, yTilt, xPan, yPan]
        addMotionEffect(parralaxMotionEffect)
    }
    
    /// Removes parallax motion effect from the `view`.
    private func removeParallaxMotionEffect() {
        guard let parralaxMotionEffect = self.parralaxMotionEffect else {
            return
        }
        
        removeMotionEffect(parralaxMotionEffect)
        self.parralaxMotionEffect = nil
    }
}
