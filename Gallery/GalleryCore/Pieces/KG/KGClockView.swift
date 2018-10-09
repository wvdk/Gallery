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
    private let contentView = UIView()

    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        layer.opacity = 0.8
        
//        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(randomLine), userInfo: nil, repeats: true)
        
        contentView.alpha = 0.4
        addSubview(contentView)
        contentView.constraint(edgesTo: self)
        
        loopingLines()
        setupTimeLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rotateLines()
    }
    
    // MARK - UI setup
    
    private func setupTimeLabel() {
        let fontSize = 130 * frame.height / 1119
        timeLabel.font = UIFont(name: "Courier", size: fontSize)
        timeLabel.textColor = .white
        timeLabel.alpha = 0.9
        
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
    
//    @objc private func randomLine() {
//        var randomInFrame: CGPoint {
//            return CGPoint(x: CGFloat.random(in: 0...self.frame.width), y: CGFloat.random(in: 0...self.frame.height))
//        }
//
//        let bezierPath = UIBezierPath()
//        let xPosition = CGFloat.random(in: 0...self.frame.width)
//        bezierPath.move(to: CGPoint(x: xPosition, y: 0))
//        bezierPath.addLine(to: CGPoint(x: xPosition, y: self.frame.height))
//
//        let lineLayer = KGLineLayer(path: bezierPath.cgPath, hasShadow: true)
//        lineLayer.opacity = 0.8
//        layer.addSublayer(lineLayer)
//
//        let duration = Double.random(in: 3...8)
//        let delay = 0.5
//        let repeatCount = Float.infinity
//
//        lineLayer.strokeAnimation(duration: duration, delay: delay, repeatCount: repeatCount)
//    }
    
    private func loopingLines() {
        let line = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 1, height: self.frame.height * 2)))
        contentView.addSubview(line)

        line.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        line.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
        line.alpha = 0.05
        
        line.loopInSuperview(duplicationCount: 60, with: [
            .rotateByDegrees(-0.02),
            .moveHorizontallyWithIncrement(50 * frame.width / 1920),
            .updateOpacityRandomly
            ]
        )
    }
    
    // MARK - Time update
    
    @objc private func updateTime() {
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    }
    
    // MARK - Rotation initialization
    
    private func rotateLines() {
        for subview in contentView.subviews {
            subview.rotate(duration: 220.0)
        }
    }
}

//extension CGPoint {
//
//    func add(constant: CGFloat) -> CGPoint {
//        return CGPoint(x: self.x + constant, y: self.y + constant)
//    }
//}
