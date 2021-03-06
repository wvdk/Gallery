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
    
    private var mazeContainerView = UIView()

    private let lineDrawDuration = 0.1
    private var isInFullScreen = false
    private var mazeCount = 0
    
    private var maxMazeCount: Int {
        return isInFullScreen ? 10 : 5
    }

    private var defaultMazeFrame: CGRect {
        let height = self.frame.height * ( 1 - 300 / 1119)
        let width = self.frame.width * ( 1 - 300 / 1920)
        
        let frame = CGRect(x: self.frame.size.width / 2 - width / 2,
                           y: self.frame.size.height / 2 - height / 2,
                           width: width,
                           height: height)
        
        return frame
    }
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.layer.opacity = 0.9
        addSubview(backgroundView)
        backgroundView.constraint(edgesTo: self)
        
        addSubview(mazeContainerView)
        mazeContainerView.constraint(edgesTo: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
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
        
        setupMaze()
    }

    // MARK: - Art piece setup
    
    private func restartMaze() {
        mazeCount += 1

        if self.mazeCount < maxMazeCount {
            setupMaze()
            return
        }
        
        let hideDuration = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + hideDuration) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.mazeCount = 0
            self.mazeContainerView.layer.sublayers?.forEach { $0.removeAllAnimations() }
            self.mazeContainerView.layer.sublayers?.removeAll()
            self.setupMaze()
        }
    }
        
    private func setupMaze() {
        let cellSize = CGFloat.random(in: 10...40) * self.frame.height / 1119

        controller.setup(size: KGVertexListSize(columns: Int(defaultMazeFrame.width / cellSize), rows: Int(defaultMazeFrame.height / cellSize)))
        controller.compute()
        
        let actions = controller.mazeActions
        perform(vertexDrawingActions: actions, in: defaultMazeFrame, cellSize: cellSize)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(actions.count) * lineDrawDuration) { [weak self] in
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
        
        mazeContainerView.layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.toValue = 0.5
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        showAnimation.isRemovedOnCompletion = false
        lineLayer.add(showAnimation, forKey: "showLine")
    }
}
