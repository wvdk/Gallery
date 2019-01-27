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
    
    private var controller = KGDeStijlController()
    private var deStijlContainerView = UIView()

    private let lineDrawDuration = 0.1

    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.opacity = 0.9
        addSubview(backgroundView)
        backgroundView.constraint(edgesTo: self)
        
        self.addSubview(self.deStijlContainerView)
        deStijlContainerView.constraint(edgesTo: self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        setupDeStijl()
    }
    
    // MARK: - Art piece setup
 
    private func restartDeStijl() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self = self else { return }
            self.deStijlContainerView.layer.sublayers?.forEach { $0.removeAllAnimations() }
            self.deStijlContainerView.layer.sublayers?.removeAll()
            self.setupDeStijl()
        }
    }
    
    private func setupDeStijl() {
        let actions = controller.setup(pointCount: 20, in: self.frame)
        perform(lineDrawingActions: actions)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(actions.count) * lineDrawDuration) { [weak self] in
            guard let self = self else { return }
            self.restartDeStijl()
        }
    }
    
    // MARK: - Drawing actions
    
    private func perform(lineDrawingActions: [KGLineDrawingAction]) {
        let initialTime = CACurrentMediaTime()
        
        for action in lineDrawingActions {
            if action.type == .addition {
                addLine(with: action, beginTime: initialTime, duration: lineDrawDuration)
            }
        }
    }
    
    private func addLine(with action: KGLineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineLayer = KGLineLayer(from: action.line.cgPath, with: action.line.uuid)
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 4
        deStijlContainerView.layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.toValue = 0.95
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        showAnimation.isRemovedOnCompletion = false
        lineLayer.add(showAnimation, forKey: "showLine")
    }
}
