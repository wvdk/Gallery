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
    
    override var canBecomeFocused: Bool {
        return true
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    
    func addSubview(artView: ArtView) {
//        artView.clipsToBounds = true

        self.addSubview(artView)
        
        artView.translatesAutoresizingMaskIntoConstraints = false
        
        artView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        artView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        artView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        artView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    // MARK: - Focus updates
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView as? FocusingView != nil {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.setFocusedStyle()
            }, completion: nil)
        }
        
        if context.previouslyFocusedView as? FocusingView != nil {
            coordinator.addCoordinatedUnfocusingAnimations({ [weak self] (animationContext) in
                self?.resetFocusedStyle()
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
}
