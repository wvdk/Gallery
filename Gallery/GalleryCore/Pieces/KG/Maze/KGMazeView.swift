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
    
    private var mazeCount = 0
    private var lineDrawDuration = 0.1
    
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
    }
    
    // MARK: - Art piece setup
    
    private func restartMaze() {
        let hideDuration = 2.0
        mazeCount += 1

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
    
    private var defaultFrame: CGRect {
        let height = self.frame.height * ( 1 - 300 / 1119)
        let width = self.frame.width * ( 1 - 300 / 1920)
        
        let frame = CGRect(x: self.frame.size.width / 2 - width / 2,
                           y: self.frame.size.height / 2 - height / 2,
                           width: width,
                           height: height)
        
        return frame
    }
    
    private func setupMaze() {
        let cellSize = CGFloat.random(in: 5...40)

        controller.setup(size: KGVertexListSize(columns: Int(defaultFrame.width / cellSize), rows: Int(defaultFrame.height / cellSize)))
        controller.compute()
        
        let actions = controller.mazeActions
        perform(vertexDrawingActions: actions, in: defaultFrame, cellSize: cellSize)
        
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
    
        let randomColor = UIColor(r: Int.random(in: 50...255), g: Int.random(in: 50...255), b: Int.random(in: 50...255)).cgColor
        lineLayer.strokeColor = randomColor
        lineLayer.lineWidth = cellSize / 2
        
        layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.toValue = 0.5
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        showAnimation.isRemovedOnCompletion = false
        lineLayer.add(showAnimation, forKey: "showLine")
    }
}
