//
//  KGConvexHullScanController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGConvexHullScanController {
    
    // MARK: - Properties
    
    var convexHullScanActions: [KGLineDrawingAction] {
        return pointActionBuffer
    }
    
    private(set) var points = [CGPoint]()
    
    private let algorithm = KGConvexHullScanAlgorithm()
    
    fileprivate var pointActionBuffer = [KGLineDrawingAction]()
    fileprivate var actionIndex = 0
    
    // MARK: - Initialization
    
    func setup(pointCount: Int, in rect: CGRect) {
        reset()

        for _ in 0...pointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX), y: CGFloat.random(in: rect.minY...rect.maxY))
            points.append(newPoint)
        }
        
        algorithm.delegate = self
    }
    
    private func reset() {
        points = []
        actionIndex = 0
        pointActionBuffer = []
    }
    
    // MARK: - Compute methods
    
    @discardableResult func compute() -> [CGPoint] {
        return algorithm.compute(points: points)
    }
}

extension KGConvexHullScanController: KGConvexHullScanAlgorithmDelegate {
    
    func kgConvexHullScanAlgorithm(_ algorithm: KGConvexHullScanAlgorithm, didAddLine line: KGLine) {
        let action = KGLineDrawingAction(line: line, type: .addition, index: actionIndex)
        pointActionBuffer.append(action)
        actionIndex += 1
    }
    
    func kgConvexHullScanAlgorithm(_ algorithm: KGConvexHullScanAlgorithm, didRemoveLine line: KGLine) {
        let action = KGLineDrawingAction(line: line, type: .removal, index: actionIndex)
        pointActionBuffer.append(action)
        actionIndex += 1
    }
}
