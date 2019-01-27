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
    private var lineContainerView = UIView()
    private var colorContainerView = UIView()

    private let lineDrawDuration = 0.1

    private var points = [CGPoint]()
    
    var color: UIColor {
        let random = Int.random(in: 0...2)
        switch random {
        case 0:
            return .red
        case 1:
            return .blue
        default:
            return .yellow
        }
    }
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.layer.opacity = 0.9
        addSubview(backgroundView)
        backgroundView.constraint(edgesTo: self)
        
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
        
        setupDeStijl()
    }
    
    // MARK: - Art piece setup
    
    private func setupDeStijl() {
        let actions = controller.setup(pointCount: 30, in: self.frame)
        perform(lineDrawingActions: actions)
        
        if points.count > 0 {
            points = []
        }
        
        for action in actions {
            let line = action.line
            points.append(contentsOf: [line.startPoint, line.endPoint])
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(actions.count) * lineDrawDuration) { [weak self] in
            guard let self = self else { return }
            self.restartDeStijl()
        }
    }
    
    private func restartDeStijl() {
        setupFilling()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self = self else { return }
            self.lineContainerView.layer.sublayers?.forEach { $0.removeAllAnimations() }
            self.lineContainerView.layer.sublayers?.removeAll()
            self.colorContainerView.subviews.forEach { $0.removeFromSuperview() }

            self.setupDeStijl()
        }
    }
    
    private func setupFilling() {
        for _ in 0...7 {
            findRects()
        }
    }
    
    private func findRects() {
        guard points.count > 0 else { return }
        
        let random = Int.random(in: 0..<points.count)
        let point = points[random]
        
        let sameYPoints = points.filter { $0.x != point.x && $0.y == point.y }
        let sameYPoint = sameYPoints.min { a, b -> Bool in
            return a.distance(to: point) < b.distance(to: point)
        }
        
        guard sameYPoint != nil else { return }
        let sameXPointsForYPoint = points.filter { $0.x == sameYPoint!.x && $0.y != sameYPoint!.y }
        let sameXPointsForPoint = points.filter { $0.x == point.x && $0.y != point.y }
        
        var anotherYPoint: CGPoint? {
            for pointA in sameXPointsForYPoint{
                for pointB in sameXPointsForPoint {
                    if pointA.y == pointB.y {
                        return pointA
                    }
                }
            }
            
            return nil
        }
        
        guard anotherYPoint != nil else { return }

        let rect = CGRect.make(point, anotherYPoint!)
        let view = UIView(frame: rect)
        view.backgroundColor = color
        colorContainerView.addSubview(view)
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
        lineLayer.lineWidth = 3
        lineContainerView.layer.addSublayer(lineLayer)
        
        let showAnimation = CABasicAnimation(keyPath: "opacity")
        showAnimation.fillMode = CAMediaTimingFillMode.forwards
        showAnimation.toValue = 0.95
        showAnimation.beginTime = beginTime + duration * Double(action.index)
        showAnimation.duration = duration
        showAnimation.isRemovedOnCompletion = false
        lineLayer.add(showAnimation, forKey: "showLine")
    }
}

extension CGRect {
    
    static func make(_ point1: CGPoint, _ point2: CGPoint) -> CGRect {
        return CGRect(x: min(point1.x, point2.x),
                      y: min(point1.y, point2.y),
                      width: abs(point1.x - point2.x),
                      height: abs(point1.y - point2.y))
    }
}
