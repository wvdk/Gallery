//
//  KGClockView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/9/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGClockView: UIView {
    
    // MARK: - Properties
    
    private var timeLabel = UILabel()

    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        layer.opacity = 0.9
        
//        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(randomLine), userInfo: nil, repeats: true)
        
//        for _ in 0...3 {
//            randomLine()
//        }
        
        setupTimeLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
//        for _ in 0...3 {
//            randomLine()
//        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
//        for _ in 0...3 {
//            randomLine()
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for _ in 0...10 {
            randomLine()
        }
    }
    
    // MARK - UI setup
    
    private func setupTimeLabel() {
        let fontSize = 150 * frame.height / 1119
        timeLabel.font = UIFont(name: "Courier", size: fontSize)
        timeLabel.textColor = .white
        
        timeLabel.layer.shadowColor = UIColor.white.cgColor
        timeLabel.layer.shadowOffset = .zero
        timeLabel.layer.shadowRadius = 4
        timeLabel.layer.shadowOpacity = 1
        timeLabel.layer.masksToBounds = false
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        updateTime()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func randomLine() {
        var randomInFrame: CGPoint {
            return CGPoint(x: CGFloat.random(in: 0...self.frame.width), y: CGFloat.random(in: 0...self.frame.height))
        }
        
        let bezierPath = UIBezierPath()
        let xPosition = CGFloat.random(in: 0...self.frame.width)
        bezierPath.move(to: CGPoint(x: xPosition, y: 0))
        bezierPath.addLine(to: CGPoint(x: xPosition, y: self.frame.height))
        
        let lineLayer = KGLineLayer(path: bezierPath.cgPath, hasShadow: true)
        lineLayer.opacity = 0.3
        layer.addSublayer(lineLayer)
        
        let duration = Double.random(in: 3...8)
        let delay = 0.5
        let repeatCount = Float.infinity
        
        lineLayer.strokeAnimation(duration: duration, delay: delay, repeatCount: repeatCount)
//        lineLayer.colorAnimation(duration: duration + delay, repeatCount: repeatCount)
    }
    
    // MARK - Time update
    
    @objc private func updateTime() {
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    }
}

