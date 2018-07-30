//
//  FocusedLabel.swift
//  GalleryCore tvOS
//
//  Created by Kristina Gelzinyte on 7/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class FocusingLabel: UILabel {
    
    // MARK: - Properties
    
    override public var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.textColor = .darkGray
        self.font = UIFont.systemFont(ofSize: 20)
        
        self.layer.masksToBounds = false
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Focus updates
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView as? FocusingLabel != nil {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.setFocusedStyle()
            }, completion: nil)
        }
        
        if context.previouslyFocusedView as? FocusingLabel != nil {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                self?.resetFocusedStyle()
            }, completion: nil)
        }
    }
    
    // MARK: - Focus appearance
    
    private func setFocusedStyle() {
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)

        self.textColor = .white

        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
    }
    
    private func resetFocusedStyle() {
        self.transform = CGAffineTransform.identity

        self.textColor = .darkGray

        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
