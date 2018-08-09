//
//  FocusingLabel.swift
//  GalleryCore tvOS
//
//  Created by Kristina Gelzinyte on 7/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UILabel` which can become focused when system updates the focus for views.
///
/// In focused mode implements parallax effect.
///
/// Default settings:
/// - Dark gray text color
/// - System font of size 20.
class FocusingLabel: UILabel {
    
    // MARK: - UILabel properties
    
    override public var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        isUserInteractionEnabled = true
        textColor = .darkGray
        font = UIFont.systemFont(ofSize: 20)
        
        layer.masksToBounds = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIFocusEnvironment update

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // Animates label's appearance to be focused.
        if context.nextFocusedView as? FocusingLabel != nil {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.setFocusedStyle()
            }, completion: nil)
        }
        
        // Animates label's appearance to not be focused.
        if context.previouslyFocusedView as? FocusingLabel != nil {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                self?.resetFocusedStyle()
            }, completion: nil)
        }
    }
    
    // MARK: - Focus appearance
    
    /// Sets focus style to the label:
    /// - Scales by 1.2.
    /// - Sets text color to white.
    /// - Adds significant drop down shadow to the view's layer.
    private func setFocusedStyle() {
        transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        textColor = .white

        layer.shadowRadius = 5
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    
    /// Removes focus style from the view.
    private func resetFocusedStyle() {
        transform = CGAffineTransform.identity

        textColor = .darkGray

        layer.shadowRadius = 0
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
