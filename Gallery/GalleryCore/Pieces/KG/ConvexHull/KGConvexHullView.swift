//
//  KGConvexHullView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SpriteKit

class KGConvexHullView: UIView {
    
    // MARK: - Properties
    
    
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
    }
    
    // MARK: - Drawing actions
    
    private func perform(lineDrawingActions: [KGLineDrawingAction]) {
        let duration = 0.3
        let initialTime = CACurrentMediaTime()
        
        for action in lineDrawingActions {
            switch action.type {
            case .addition:
                addLine(with: action, beginTime: initialTime, duration: duration)
            case .removal:
                removeLine(with: action, beginTime: initialTime, duration: duration)
            }
        }
    }
    
    private func addLine(with action: KGLineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineLayer = KGLineLayer(from: action.line.cgPath, with: action.line.uuid)
        layer.addSublayer(lineLayer)
        
        let drawAnimation = CABasicAnimation(keyPath: "opacity")
        drawAnimation.fillMode = CAMediaTimingFillMode.forwards
        drawAnimation.toValue = 1
        drawAnimation.beginTime = beginTime + duration * Double(action.index)
        drawAnimation.duration = duration
        drawAnimation.isRemovedOnCompletion = false
        lineLayer.add(drawAnimation, forKey: "showLine")
    }
    
    private func removeLine(with action: KGLineDrawingAction, beginTime: TimeInterval, duration: Double) {
        let lineToRemove = layer.sublayers?.first { layer in
            if let lineLayer = layer as? KGLineLayer, lineLayer.uuid == action.line.uuid {
                return true
            }
            return false
        }
        
        guard lineToRemove != nil else {
            NSLog("Asking to remove non existing line")
            return
        }
        
        let drawAnimation = CABasicAnimation(keyPath: "opacity")
        drawAnimation.fillMode = CAMediaTimingFillMode.forwards
        drawAnimation.toValue = 0
        drawAnimation.beginTime = beginTime + duration * Double(action.index)
        drawAnimation.duration = duration / 2
        drawAnimation.isRemovedOnCompletion = false
        lineToRemove!.add(drawAnimation, forKey: "hideLine")
    }
}
