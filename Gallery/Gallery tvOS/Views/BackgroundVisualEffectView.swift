//
//  BackgroundVisualEffectView.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UIVisualEffectView`.
///
/// Returns darker than default `regular` style `UIVisualEffectView`.
class BackgroundVisualEffectView: UIVisualEffectView {
    
    // MARK: - Initializer
    
    convenience init() {
        self.init(effect: UIBlurEffect(style: .regular))
        
        let background = UIView(frame: bounds)
        background.backgroundColor = .black
        background.alpha = 0.33
        
        contentView.addSubview(background)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        
        background.constraint(edgesTo: contentView)
    }
}
