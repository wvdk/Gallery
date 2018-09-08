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
    
    /// The object that acts as the delegate of the `FocusingViewDelegate`.
    weak var delegate: FocusingViewDelegate?
    
    /// Thumbnail image of the art piece.
    var thumbnail: UIImage? = nil {
        didSet {
            thumbnailView.image = thumbnail ?? UIImage(named: "defaultThumbnail")
        }
    }
    
    private var artPieceViewParralaxMotionEffect: UIMotionEffectGroup?
    
    private let containerView = UIView()
    private let thumbnailView = UIImageView()
    
    // MARK: - UIView properties
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        
        addSubview(containerView)
        containerView.addSubview(thumbnailView)
        
        containerView.constraint(edgesTo: self)
        thumbnailView.constraint(edgesTo: containerView)
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8
        
        addDefaultShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subview management.
    
    /// Adds a specific view to the end of the receiver’s list of subviews.
    /// - Parameters:
    ///     - subview: A new view of type `ArtView` to be added.
    ///     - animated: Booleon set to true animates the specified subview appearance, by default set to true.
    func show(subview: ArtView, animated: Bool = true) {
        if animated {
            subview.alpha = 0
        }
        containerView.addSubview(subview)
        subview.constraint(edgesTo: containerView)
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                subview.alpha = 1
            }
        }
    }
    
    /// Hides and removes a specific view from the receiver’s list of subviews.
    /// - Parameters:
    ///     - subview: A new view of type `ArtView` to be hidden/removed.
    ///     - animated: Booleon set to true animates the specified subview disappearance, by default set to true.
    func hide(subview: ArtView, animated: Bool = true) {
        if containerView.subviews.contains(subview) {
            if animated {
                UIView.animate(withDuration: 0.2, animations: {
                    subview.alpha = 0
                }, completion: { completed in
                    if completed {
                        subview.removeFromSuperview()
                    }
                })
            } else {
                subview.removeFromSuperview()
            }
        }
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        // Animates view's appearance to be focused.
        if let nextFocusedView = context.nextFocusedView as? FocusingView, nextFocusedView == self {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                if let strongSelf = self {
                    strongSelf.setFocusedStyle()
                    strongSelf.addParallaxMotionEffect()
                }}, completion: { [weak self] in
                    if let strongSelf = self {
                        strongSelf.delegate?.focusingViewDidBecomeFocused(strongSelf)
                    }
            })
        }
        
        // Animates view's appearance to be not focused.
        if let previouslyFocusedView = context.previouslyFocusedView as? FocusingView, previouslyFocusedView == self {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                if let strongSelf = self {
                    strongSelf.resetFocusedStyle()
                    strongSelf.removeParallaxMotionEffect()
                }}, completion: { [weak self] in
                    if let strongSelf = self {
                        strongSelf.delegate?.focusingViewDidResignedFocus(strongSelf)
                    }
            })
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
    private func setFocusedStyle() {
        layer.shadowRadius = 15
        layer.shadowOffset = CGSize(width: 0, height: 25)
    }
    
    /// Removes focus style from the view.
    private func resetFocusedStyle() {
        addDefaultShadow()
    }
    
    /// Adds small drop down type shadow to the view's layer.
    private func addDefaultShadow() {
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

/// The object that acts as the delegate of the focusing view.
///
/// The delegate must adopt the FocusingViewDelegate protocol.
///
/// The delegate object is responsible for managing the focusing view focus state.
protocol FocusingViewDelegate: class {
    
    /// Tells the delegate that the view became focused.
    ///
    /// - Parameters:
    ///     - focusingView: An object informing the delegate that view became focused.
    func focusingViewDidBecomeFocused(_ focusingView: FocusingView)
    
    /// Tells the delegate that the view resign the focus.
    ///
    /// - Parameters:
    ///     - focusingView: An object informing the delegate that view resign focus.
    func focusingViewDidResignedFocus(_ focusingView: FocusingView)
}
