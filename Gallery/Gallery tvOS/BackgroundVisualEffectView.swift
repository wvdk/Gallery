//
//  BackgroundVisualEffectView.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class BackgroundVisualEffectView: UIVisualEffectView {
    
    // MARK: - Initializer
    
    convenience init() {
        self.init(effect: UIBlurEffect(style: .regular))
        
        let background = UIView(frame: self.bounds)
        background.backgroundColor = .black
        background.alpha = 0.33
        
        contentView.addSubview(background)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        
        background.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        background.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
}
