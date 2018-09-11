//
//  GradientBackgroundView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/10/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class GradientBackgroundView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let linearGradient = CAGradientLayer()
        layer.addSublayer(linearGradient)
        linearGradient.frame = bounds
        linearGradient.colors = [
            UIColor(r: 186, g: 247, b: 253, alpha: 0.11).cgColor,
            UIColor(r: 41, g: 56, b: 57, alpha: 0.65).cgColor,
            UIColor(r: 0, g: 0, b: 0, alpha: 1.0).cgColor
        ]
        linearGradient.locations = [
            NSNumber(value: 0),
            NSNumber(value: 1 - 950 / 1119),
            NSNumber(value: 1 - 1082 / 1119)
        ]
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = frame.size.height * 790 / 1119
        let colors = [UIColor(r: 186, g: 247, b: 253, alpha: 1).cgColor, UIColor(r: 255, g: 255, b: 255, alpha: 0).cgColor]
        let radialGradient = RadialGradientLayer(startCenter: center,
                                                 endCenter: center,
                                                 startRadius: 0,
                                                 endRadius: radius,
                                                 colors: colors)
        layer.addSublayer(radialGradient)
        radialGradient.frame = bounds
        radialGradient.opacity = 0.2
        
        let diagonalGradient = CAGradientLayer()
        layer.addSublayer(diagonalGradient)
        diagonalGradient.frame = bounds
        diagonalGradient.opacity = 0.2
        diagonalGradient.startPoint = CGPoint(x: 1, y: 0)
        diagonalGradient.endPoint = CGPoint(x: 0, y: 1)
        diagonalGradient.colors = [
            UIColor(r: 186, g: 247, b: 253, alpha: 1).cgColor,
            UIColor(r: 31, g: 50, b: 50, alpha: 1).cgColor
        ]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
