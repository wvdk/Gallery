//
//  KGClockView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class KGClockView: UIView {
    
    // MARK: - Properties
    
    private let secondsLayer: CALayer
    private let minutesLayer: CALayer
    private let hoursLayer: CALayer
    
    private var second: CGFloat {
        return CGFloat(Calendar.current.component(.second, from: Date()))
    }
    
    private var minute: CGFloat {
        return CGFloat(Calendar.current.component(.minute, from: Date()))
    }
    
    private var hour: CGFloat {
        return CGFloat(Calendar.current.component(.hour, from: Date()))
    }
    
    private var secondAngle: CGFloat {
        return .pi * second / 30
    }
    
    private var minuteAngle: CGFloat {
        return .pi * minute / 30 + secondAngle / 60
    }
    
    private var hourAngle: CGFloat {
        return .pi * hour / 6 + minuteAngle / 60 + secondAngle / 3600
    }
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        secondsLayer = CALayer()
        minutesLayer = CALayer()
        hoursLayer = CALayer()

        super.init(frame: frame)
        
        backgroundColor = UIColor(r: 74, g: 68, b: 68)
        
        secondsLayer.backgroundColor = UIColor(r: 196, g: 93, b: 105).cgColor
        minutesLayer.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        hoursLayer.backgroundColor = UIColor(r: 180, g: 180, b: 180).cgColor
        
        let w = (frame.size.width + frame.size.height) * 0.3
        
        secondsLayer.anchorPoint = CGPoint(x: 0.5, y: 0.95)
        minutesLayer.anchorPoint = CGPoint(x: 0.5, y: 1 - 13 / (w / 2))
        hoursLayer.anchorPoint = CGPoint(x: 0.5, y: 1 - 13 / (w / 2))

        secondsLayer.frame = CGRect(x: 0, y: 0, width: 4, height: 20 + w / 2)
        minutesLayer.frame = CGRect(x: 0, y: 0, width: 26, height: w / 2)
        hoursLayer.frame = CGRect(x: 0, y: 0, width: 26, height: w / 3)
        
        secondsLayer.cornerRadius = 2
        minutesLayer.cornerRadius = 13
        hoursLayer.cornerRadius = 13
        
        secondsLayer.shadowOffset = .zero
        minutesLayer.shadowOffset = .zero
        hoursLayer.shadowOffset = .zero
        
        secondsLayer.shadowRadius = 1
        minutesLayer.shadowRadius = 1
        hoursLayer.shadowRadius = 1
        
        secondsLayer.shadowOpacity = 0.15
        minutesLayer.shadowOpacity = 0.15
        hoursLayer.shadowOpacity = 0.15

        let centerPoint = CGPoint(x: frame.origin.x + frame.size.width / 2, y: frame.origin.y + frame.size.height / 2)
        secondsLayer.position = centerPoint
        minutesLayer.position = centerPoint
        hoursLayer.position = centerPoint
        
        let pinLayer = CALayer()
        pinLayer.backgroundColor = UIColor(r: 57, g: 54, b: 54).cgColor
        pinLayer.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        pinLayer.position = centerPoint
        pinLayer.cornerRadius = 7
        
        self.layer.addSublayer(hoursLayer)
        self.layer.addSublayer(minutesLayer)
        self.layer.addSublayer(secondsLayer)
        self.layer.addSublayer(pinLayer)

        updateTime()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    // MARK: - Time update

    @objc private func updateTime() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .linear))
        secondsLayer.transform = CATransform3DMakeRotation(secondAngle, 0, 0, 1)
        minutesLayer.transform = CATransform3DMakeRotation(minuteAngle, 0, 0, 1)
        hoursLayer.transform = CATransform3DMakeRotation(hourAngle, 0, 0, 1)
        CATransaction.commit()
    }
}
