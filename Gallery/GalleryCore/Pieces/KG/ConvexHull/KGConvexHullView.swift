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
    
    var controller = KGConvexHullScanController()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        setupAndScanConvexHull()
    }
    
    // MARK: - Art piece setup
    
    fileprivate func restartConvexHull() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) { [weak self] in
            self?.layer.sublayers?.forEach { $0.removeAllAnimations() }
            self?.layer.sublayers?.removeAll()
            self?.setupAndScanConvexHull()
        }
    }
    
    // MARK: - Convex Hull Scan
    
    private func setupAndScanConvexHull() {
        let pointsCount = Int.random(in: 20...50)

        let height = CGFloat.random(in: 200...self.frame.height)
        let width = CGFloat.random(in: 200...self.frame.width)
        let convexHullRectange = CGRect(x: self.frame.size.width / 2 - width / 2,
                                        y: self.frame.size.height / 2 - height / 2,
                                        width: width,
                                        height: height)
        
//                let testView = UIView(frame: convexHullRectange)
//                testView.backgroundColor = .red
//                self.addSubview(testView)
//                self.sendSubviewToBack(testView)
//        
        
        controller.setup(pointCount: pointsCount, in: convexHullRectange)
        controller.compute()
        
        let actions = controller.convexHullScanActions
        perform(lineDrawingActions: actions)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(actions.count) * 0.1) { [weak self] in
            self?.restartConvexHull()
        }
    }
    
    // MARK: - Drawing actions
    
    private func perform(lineDrawingActions: [KGLineDrawingAction]) {
        let duration = 0.1
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
