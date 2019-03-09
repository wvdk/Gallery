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
    
    private lazy var timer = {
        return Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateTime), userInfo: nil, repeats: true)
    }()
    
    private var seconds: CGFloat {
        return CGFloat(Calendar.current.component(.second, from: Date()))
    }
    
    private var minutes: CGFloat {
        return CGFloat(Calendar.current.component(.minute, from: Date()))
    }
    
    private var hours: CGFloat {
        return CGFloat(Calendar.current.component(.hour, from: Date()))
    }
    
    private var secondsAngle: CGFloat {
        return .pi * (seconds + 1) / 30
    }
    
    private var minutesAngle: CGFloat {
        return .pi * minutes / 30 + secondsAngle / 60
    }
    
    private var hoursAngle: CGFloat {
        return .pi * hours / 6 + minutesAngle / 12
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        secondsLayer = CALayer()
        minutesLayer = CALayer()
        hoursLayer = CALayer()
        
        super.init(frame: frame)
        
        let isInFullScreen = frame.size == UIScreen.main.bounds.size

        configureBackground(frame: frame, isInFullScreen: isInFullScreen)
        configureNumbers(frame: frame, isInFullScreen: isInFullScreen)
        configureArrows(frame: frame, isInFullScreen: isInFullScreen)
        
        updateTime()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            timer.invalidate()
        } else {
            timer.fire()
        }
    }
    
    // MARK: - View
    
    private func configureBackground(frame: CGRect, isInFullScreen: Bool) {
        let background = UIView()
        background.backgroundColor = UIColor(r: 74, g: 74, b: 74)
        
        let circle = CAShapeLayer()
        let length = 0.375 * frame.width
        let rect = CGRect(x: (frame.width - length) * 0.5, y: (frame.height - length) * 0.5, width: length, height: length)
        circle.path = UIBezierPath(ovalIn: rect).cgPath
        circle.fillColor = UIColor.white.cgColor
        
        let bottomPinLayer = CALayer()
        bottomPinLayer.backgroundColor = UIColor(r: 74, g: 74, b: 74).cgColor
        bottomPinLayer.frame = CGRect(x: 0, y: 0, width: isInFullScreen ? 24 : 12, height: isInFullScreen ? 24 : 12)
        bottomPinLayer.position = CGPoint(x: frame.origin.x + frame.size.width / 2, y: frame.origin.y + frame.size.height / 2)
        bottomPinLayer.cornerRadius = isInFullScreen ? 12 : 6
        
        background.layer.addSublayer(circle)
        background.layer.addSublayer(bottomPinLayer)

        self.addSubview(background)
        background.constraint(edgesTo: self)
    }
    
    private func configureArrows(frame: CGRect, isInFullScreen: Bool) {
        secondsLayer.backgroundColor = UIColor(r: 196, g: 93, b: 105).cgColor
        minutesLayer.backgroundColor = UIColor(r: 74, g: 74, b: 74).cgColor
        hoursLayer.backgroundColor = UIColor(r: 74, g: 74, b: 74).cgColor
        
        secondsLayer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
        minutesLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        hoursLayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        let w = frame.width * 0.356
        secondsLayer.frame = CGRect(x: 0, y: 0, width: isInFullScreen ? 4 : 2, height: w * 0.55)
        minutesLayer.frame = CGRect(x: 0, y: 0, width: isInFullScreen ? 12 : 6, height: w * 0.5)
        hoursLayer.frame = CGRect(x: 0, y: 0, width: isInFullScreen ? 12 : 6, height: w * 0.33)
        
        secondsLayer.cornerRadius = isInFullScreen ? 2 : 1
        minutesLayer.cornerRadius = isInFullScreen ? 10 : 5
        hoursLayer.cornerRadius = isInFullScreen ? 10 : 5

        let centerPoint = CGPoint(x: frame.origin.x + frame.size.width / 2, y: frame.origin.y + frame.size.height / 2)
        secondsLayer.position = centerPoint
        minutesLayer.position = centerPoint
        hoursLayer.position = centerPoint
        
        let pinLayer = CALayer()
        pinLayer.backgroundColor = UIColor(r: 196, g: 93, b: 105).cgColor
        pinLayer.frame = CGRect(x: 0, y: 0, width: isInFullScreen ? 10 : 6, height: isInFullScreen ? 10 : 6)
        pinLayer.position = centerPoint
        pinLayer.cornerRadius = isInFullScreen ? 5 : 3
        
        let view = UIView()
        self.addSubview(view)
        view.constraint(edgesTo: self)
        
        view.layer.addSublayer(hoursLayer)
        view.layer.addSublayer(minutesLayer)
        view.layer.addSublayer(secondsLayer)
        view.layer.addSublayer(pinLayer)
    }
    
    private func configureNumbers(frame: CGRect, isInFullScreen: Bool) {
        let view = UIView()
        self.addSubview(view)
        view.constraint(edgesTo: self)
        
        func angle(for hour: CGFloat) -> CGFloat {
            return .pi * hour / 6
        }
        
        for index in 1...12 {
            let number = UILabel()
            number.textColor = UIColor(r: 74, g: 74, b: 74)
            number.font = UIFont.systemFont(ofSize: isInFullScreen ? 50 : 25, weight: .bold)
            number.text = "\(index)"
            number.sizeToFit()
            
            let w = 0.16 * frame.width
            let x = frame.size.width / 2 +  w * sin(angle(for: CGFloat(index)))
            let y = frame.size.height / 2 - w * cos(angle(for: CGFloat(index)))
            number.center = CGPoint(x: x, y: y)
            
            view.addSubview(number)
        }
    }
    
    // MARK: - Time update

    @objc private func updateTime() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .linear))
        secondsLayer.transform = CATransform3DMakeRotation(secondsAngle, 0, 0, 1)
        minutesLayer.transform = CATransform3DMakeRotation(minutesAngle, 0, 0, 1)
        hoursLayer.transform = CATransform3DMakeRotation(hoursAngle, 0, 0, 1)
        CATransaction.commit()
    }
}
