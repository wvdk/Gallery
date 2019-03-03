//
//  KGSecretClockView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class KGSecretClockView: UIView {
    
    // MARK: - Properties
    
    private var timeLabel = UILabel()

    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        layer.opacity = 0.7

        setupTimeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        showTimeLabel()
    }
    
    // MARK: - Clock setup
    
    private func setupTimeLabel() {
        let fontSize = 0.134 * frame.height
        timeLabel.font = UIFont(name: "Menlo", size: fontSize)
        timeLabel.textColor = .white
        timeLabel.alpha = 0.6
        
        addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        updateTime()
    }
    
    // MARK: - Clock appearance
    
    private func showTimeLabel() {
        updateTime()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH mm ss"
        timeLabel.text = formatter.string(from: Date())
    }
}
