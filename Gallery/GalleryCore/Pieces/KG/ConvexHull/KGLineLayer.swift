//
//  KGLineLayer.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGLineLayer: CAShapeLayer {
    
    private(set) var uuid: String!
    
    /// Opacity is set to 0.
    convenience init(from path: CGPath, color: CGColor = UIColor.white.cgColor, with uuid: String) {
        self.init()
        
        self.uuid = uuid
        
        self.path = path
        self.strokeColor = color
        self.lineWidth = 1
        self.opacity = 0
    }
    
    convenience init(path: CGPath? = nil, hasShadow: Bool = true) {
        self.init()
        self.path = path
                
        self.lineWidth = 1
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor(r: Int.random(in: 0...255), g: Int.random(in: 0...255), b: Int.random(in: 0...255)).cgColor
        
        if hasShadow {
            self.shadowColor = self.strokeColor
            self.shadowOffset = .zero
            self.shadowRadius = 10
            self.shadowOpacity = 1
            self.masksToBounds = false
        }
    }
    
    func update(path: CGPath) {
        self.path = path
    }
    
    func strokeAnimation(duration: Double, delay: Double, repeatCount: Float) {
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 1
        startAnimation.toValue = 0
        startAnimation.duration = duration
        startAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        startAnimation.isRemovedOnCompletion = false
        startAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = 1
        endAnimation.toValue = 0
        endAnimation.duration = duration
        endAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        endAnimation.beginTime = startAnimation.beginTime + delay
        
        let strokeAnimation = CAAnimationGroup()
        strokeAnimation.animations = [startAnimation, endAnimation]
        strokeAnimation.duration = duration + delay
        strokeAnimation.repeatCount = repeatCount
        self.add(strokeAnimation, forKey: "strokeAnimation")
    }
    
    func rotationAnimation(duration: Double, repeatCount: Float){
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.byValue = -CGFloat.pi / 3
        rotationAnimation.duration = duration / 6
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = repeatCount
        
        self.add(rotationAnimation, forKey: rotationAnimation.keyPath)
    }
    
    func colorAnimation(duration: Double, repeatCount: Float) {
        let colorAnimation = CABasicAnimation(keyPath: "strokeColor")
        colorAnimation.toValue = UIColor.green.cgColor
        colorAnimation.duration = duration / 2
        colorAnimation.autoreverses = true
        
        let shadowColorAnimation = CABasicAnimation(keyPath: "shadowColor")
        shadowColorAnimation.toValue = UIColor.green.cgColor
        shadowColorAnimation.duration = duration / 2
        shadowColorAnimation.autoreverses = true
        
        let strokeColorAnimation = CAAnimationGroup()
        strokeColorAnimation.animations = [colorAnimation, shadowColorAnimation]
        strokeColorAnimation.duration = duration
        strokeColorAnimation.repeatCount = repeatCount
        self.add(strokeColorAnimation, forKey: "strokeColorAnimation")
    }
}
