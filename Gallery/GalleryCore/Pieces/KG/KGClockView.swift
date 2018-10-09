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
        layer.opacity = 0.8
        
//        setupBackgroundGradient()
        setupTimeLabel()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    // MARK - UI setup
    
    private func setupTimeLabel() {
        let fontSize = 150 * frame.height / 1119
        timeLabel.font = UIFont(name: "Courier", size: fontSize)
        timeLabel.textColor = .white
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        updateTime()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    private func setupBackgroundGradient() {
        let linearGradient = CAGradientLayer()
        layer.addSublayer(linearGradient)
        
        linearGradient.frame = bounds
        linearGradient.colors = [
            UIColor(r: 184, g: 69, b: 69, alpha: 1).cgColor,
            UIColor(r: 0, g: 0, b: 0, alpha: 1).cgColor,
        ]
//        linearGradient.locations = [
//            NSNumber(value: 0.6),
//            NSNumber(value: 0.6),
//        ]
    }
    
    // MARK - Time update
    
    @objc private func updateTime() {
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    }
}

