//
//  FocusedLabel.swift
//  GalleryCore tvOS
//
//  Created by Kristina Gelzinyte on 7/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class FocusedLabel: UILabel {
    
    // MARK: - Properties
    
    override public var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Focus updates
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView as? FocusedLabel != nil {
            coordinator.addCoordinatedFocusingAnimations({ (animationContext) in
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                self.addDropShadow()
            }, completion: nil)
        }
        
        if context.previouslyFocusedView as? FocusedLabel != nil {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                self.transform = CGAffineTransform.identity
                self.removeShadow()
            }, completion: nil)
        }
    }
    
    // MARK: - Appearance
    
    private func addDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    private func removeShadow() {
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
