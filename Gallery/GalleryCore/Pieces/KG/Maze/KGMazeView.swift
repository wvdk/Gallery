//
//  KGMazeView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/2/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGMazeView: UIView {
    
    // MARK: - Properties

    private let controller = KGMazeController()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
 
        backgroundColor = .black
        layer.opacity = 0.9
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        setupMaze()
        
//        for _ in 0...10 {
//            lineAnimation()
//        }
    }
    
    // MARK: - Art piece setup
    
    private func lineAnimation() {
        let height = CGFloat.random(in: self.frame.height - 50...self.frame.height)
        let width = CGFloat.random(in: self.frame.width - 50...self.frame.width)
        
        let rect = CGRect(x: self.frame.size.width / 2 - width / 2,
                          y: self.frame.size.height / 2 - height / 2,
                          width: width,
                          height: height)
        
        let path = CGPath(rect: rect, transform: nil)
        
        let lineLayer = KGLineLayer(from: path, with: "Line layer in maze")
        
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.opacity = 1
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = UIColor(r: Int.random(in: 0...255), g: 0, b: Int.random(in: 0...255)).cgColor //UIColor.red.cgColor
        lineLayer.shadowColor = lineLayer.strokeColor
        lineLayer.shadowOffset = .zero
        lineLayer.shadowRadius = 4
        lineLayer.shadowOpacity = 1
        lineLayer.masksToBounds = false
        
        self.layer.addSublayer(lineLayer)
  
        let duration = 10.0
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
        startAnimation.fromValue = 1
        startAnimation.toValue = 0
        startAnimation.duration = duration
        startAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        startAnimation.isRemovedOnCompletion = false
        startAnimation.fillMode = CAMediaTimingFillMode.forwards
        
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
        endAnimation.fromValue = 1
        endAnimation.toValue = 0
        endAnimation.duration = duration
        endAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        endAnimation.beginTime = startAnimation.beginTime + 0.5
        
        let show = CAAnimationGroup()
        show.animations = [startAnimation, endAnimation]
        show.duration = duration + 0.5
        show.repeatCount = .infinity
        lineLayer.add(show, forKey: "show")
        
    }
    
    private var mazeCount = 0
    private var lineDrawDuration = 0.2
    
    private func restartMaze() {
        let hideDuration = 3.0
        mazeCount += 1

        if mazeCount > 10 {
            layer.sublayers?.forEach { sublayer in
                let hideAnimation = CABasicAnimation(keyPath: "opacity")
                hideAnimation.fillMode = CAMediaTimingFillMode.forwards
                hideAnimation.toValue = 0
                hideAnimation.beginTime = CACurrentMediaTime()
                hideAnimation.duration = hideDuration
                hideAnimation.isRemovedOnCompletion = false
                sublayer.add(hideAnimation, forKey: "hideLayer")
            }
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDuration) { [weak self] in
             if let self = self, self.mazeCount > 10 {
                self.mazeCount = 0
                self.layer.sublayers?.forEach { $0.removeAllAnimations() }
                self.layer.sublayers?.removeAll()
            }
            
            self?.setupMaze()
        }
    }
    
    // MARK: - Convex Hull Scan
    
    private func setupMaze() {
        let randomMazeSize = Int.random(in: 10...20)

        controller.setup(size: KGVertexListSize(columns: randomMazeSize, rows: randomMazeSize))
        controller.compute()
        
        let minHeight = 300 * self.frame.height / 1119
        let minWidth = 300 * self.frame.width / 1920

        let height = CGFloat.random(in: minHeight...self.frame.height - minHeight / 2)
        let width = CGFloat.random(in: minWidth...self.frame.width - minWidth / 2)
        let mazeRectange = CGRect(x: self.frame.size.width / 2 - width / 2,
                                  y: self.frame.size.height / 2 - height / 2,
                                  width: width,
                                  height: height)
   
        let actions = controller.mazeActions
        let cellSize = min(height / CGFloat(randomMazeSize), width / CGFloat(randomMazeSize))
        perform(vertexDrawingActions: actions, in: mazeRectange, cellSize: cellSize)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(actions.count - 1) * lineDrawDuration) { [weak self] in
            self?.restartMaze()
        }
    }
    
    // MARK: - Drawing actions
    
    private func perform(vertexDrawingActions: [KGVertexDrawingAction], in frame: CGRect, cellSize: CGFloat) {
        let initialTime = CACurrentMediaTime()
        
        for action in vertexDrawingActions {
            if action.type == .addition {
                addLine(with: action, beginTime: initialTime, duration: lineDrawDuration, in: frame, cellSize: cellSize)
            }
        }
    }
    
    private func addLine(with action: KGVertexDrawingAction, beginTime: TimeInterval, duration: Double, in frame: CGRect, cellSize: CGFloat) {
        let line = action.vertex.line(in: frame, cellSize: cellSize)
        let lineLayer = KGLineLayer(from: line.cgPath, with: line.uuid)
    
        let randomColor = UIColor(r: Int.random(in: 0...255), g: Int.random(in: 0...255), b: Int.random(in: 0...255)).cgColor
        lineLayer.strokeColor = randomColor
        lineLayer.lineWidth = cellSize / 2
        
        layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.toValue = 0.3
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        showAnimation.isRemovedOnCompletion = false
        lineLayer.add(showAnimation, forKey: "showLine")
    }
}
