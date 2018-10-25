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
    
    var controller = KGDeStijlController()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.layer.opacity = 0.9
        addSubview(backgroundView)
        backgroundView.constraint(edgesTo: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        animateBackground()

        setupDeStijl()
    }
    
    // MARK: - Art piece setup
 
    private func setupDeStijl() {
        let actions = controller.setup(pointCount: 20, in: self.frame)
        perform(lineDrawingActions: actions)
    }
    
    // MARK: - Drawing actions
    
    private func perform(lineDrawingActions: [KGLineDrawingAction]) {
        let duration = 0.1
        let initialTime = CACurrentMediaTime()
        
        for action in lineDrawingActions {
            if action.type == .addition {
                addLine(with: action, beginTime: initialTime, duration: duration)
            }
        }
    }
    
    private func addLine(with action: KGLineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineLayer = KGLineLayer(from: action.line.cgPath, with: action.line.uuid)
        layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.toValue = 0.95
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        showAnimation.isRemovedOnCompletion = false
        lineLayer.add(showAnimation, forKey: "showLine")
    }
    
    private func animateBackground() {
        let initialRect = CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: 0)
        let finalRect = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        
        let sublayer = CALayer()
        sublayer.frame = initialRect
        sublayer.anchorPoint = CGPoint(x: 0.5, y: 1)
        sublayer.backgroundColor = UIColor.orange.cgColor
        sublayer.opacity = 1

        self.layer.addSublayer(sublayer)
        
        let boundsAnim = CABasicAnimation(keyPath: "bounds")
        boundsAnim.toValue = NSValue(cgRect: finalRect)
        
        let anim = CAAnimationGroup()
        anim.animations = [boundsAnim]
        anim.isRemovedOnCompletion = false
        anim.duration = 3
        anim.fillMode = .forwards
        sublayer.add(anim, forKey: nil)
    }
}
