//
//  KGDeStijlView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGDeStijlView: UIView {
    
    // MARK: - Properties
    
    private var lineContainerView = UIView()
    private var colorContainerView = UIView()

    private let lineDrawDuration = 0.1
    private var isInFullScreen = false
    
    private var color: UIColor {
        let random = Int.random(in: 0...2)
        switch random {
        case 0:
            return UIColor(r: 255, g: 224, b: 49)
        case 1:
            return UIColor(r: 207, g: 0, b: 25)
        default:
            return UIColor(r: 0, g: 36, b: 225)
        }
    }
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        self.addSubview(colorContainerView)
        colorContainerView.constraint(edgesTo: self)
        
        self.addSubview(lineContainerView)
        lineContainerView.constraint(edgesTo: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        guard newSuperview != nil else {
            return
        }
        
        if self.frame.size == UIScreen.main.bounds.size {
            isInFullScreen = true
        }
        
        setupDeStijl()
    }
    
    // MARK: - Art piece setup
    
    private func setupDeStijl() {
        let pointCount = Int.random(in: 30...90)
        let actions = KGDeStijlController.actions(forPointCount: pointCount, in: self.bounds)
        
        let initialTime = CACurrentMediaTime()
        actions.forEach { addLine(with: $0, beginTime: initialTime, duration: lineDrawDuration) }
        
        let delay = Double(actions.count) * lineDrawDuration
        let maxFrameCount = Int.random(in: 5...30)
        let frames = KGDeStijlController.frames(for: actions, maxCount: maxFrameCount)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.fillFrames(frames)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay + 5.0) { [weak self] in
            self?.restartDeStijl()
        }
    }
    
    private func restartDeStijl() {
        self.lineContainerView.layer.sublayers?.forEach { $0.removeAllAnimations() }
        self.lineContainerView.layer.sublayers?.removeAll()
        self.colorContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        self.setupDeStijl()
    }
    
    // MARK: - Drawing actions
    
    private func addLine(with action: KGLineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineLayer = KGLineLayer(from: action.line.cgPath, with: action.line.uuid)
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = isInFullScreen ? 3 : 1.5
        lineContainerView.layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.isRemovedOnCompletion = false
        showAnimation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        
        showAnimation.toValue = 0.95
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        
        lineLayer.add(showAnimation, forKey: "showLine")
    }
    
    private func fillFrames(_ frames: [CGRect]) {
        guard frames.count > 0 else {
            return
        }
        
        frames.forEach { frame in
            let view = UIView(frame: frame)
            view.backgroundColor = color
            colorContainerView.addSubview(view)
        }
        
        let maskView = UIView(frame: self.bounds)
        maskView.backgroundColor = .white
        colorContainerView.addSubview(maskView)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
            maskView.frame = CGRect(origin: self.bounds.origin, size: CGSize(width: self.bounds.size.width, height: 0))
        }, completion: nil)
    }
}
