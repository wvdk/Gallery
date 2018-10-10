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
    
    private var timeLabel = UILabel()
    
    private var mazeContainerView = UIView()
    private var timeContainerView = UIView()

    private var lineDrawDuration = 0.1
    private var isFullScreen = false
    private var mazeCount = 0
    
    private var maxMazeCount: Int {
        return isFullScreen ? 10 : 5
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
 
        backgroundColor = .black
        layer.opacity = 0.9
        
        addSubview(mazeContainerView)
        mazeContainerView.constraint(edgesTo: self)
        
        addSubview(timeContainerView)
        timeContainerView.constraint(edgesTo: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if self.frame.size == UIScreen.main.bounds.size {
            isFullScreen = true
        }
        
        setupTimeLabel()
        setupMaze()
    }
    
    // MARK: - Clock setup
    
    private func setupTimeLabel() {
        let fontSize = 130 * frame.height / 1119
        timeLabel.font = UIFont(name: "Courier", size: fontSize)
        timeLabel.textColor = .white
        timeLabel.alpha = 0.8
        
        timeLabel.layer.shadowColor = UIColor.white.cgColor
        timeLabel.layer.shadowOffset = .zero
        timeLabel.layer.shadowRadius = 4
        timeLabel.layer.shadowOpacity = 1
        timeLabel.layer.masksToBounds = false
        
        timeContainerView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.centerXAnchor.constraint(equalTo: timeContainerView.centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: timeContainerView.centerYAnchor).isActive = true
        
        updateTime()
        
        timeContainerView.addSingleTapGestureRecognizer { [weak self] recognizer in
            recognizer.allowedPressTypes = [
                NSNumber(value: UIPress.PressType.playPause.rawValue),
                NSNumber(value: UIPress.PressType.select.rawValue)
            ]
            
            self?.showTimeLabel()
        }
        
    }
    
    // MARK: - Clock appearance

    private func showTimeLabel() {
        timeLabel.alpha = 0.8
        updateTime()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTime() {
        timeLabel.text = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
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
            guard let self = self else { return }
            
            self.mazeCount = 0
            self.mazeContainerView.layer.sublayers?.forEach { $0.removeAllAnimations() }
            self.mazeContainerView.layer.sublayers?.removeAll()
            self.setupMaze()
        }
    }
    
    // MARK: - Convex Hull Scan
    
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
