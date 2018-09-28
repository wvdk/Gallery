//
//  KGConvexHullScanAlgorithm.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGConvexHullScanAlgorithm {
    
    // MARK: - Properties
    
    weak var delegate: KGConvexHullScanAlgorithmDelegate? = nil
    
    // MARK: - Compute method
    
    @discardableResult func compute(points: [CGPoint]) -> [CGPoint] {
        let count = points.count
        
        guard count > 3 else {
            NSLog("received <= 3 points.")
            return points
        }
        
        // Sort by x coordinate, if ==, by y coordinate.
        let sortedPoints = points.sorted { (firstPoint, secondPoint) -> Bool in
            if firstPoint.x == secondPoint.x {
                return firstPoint.y < secondPoint.y
            }
            
            return firstPoint.x < secondPoint.x
        }
        
        var lines = [KGLine]()
        
        func requestLineAddition(fromPoint: CGPoint, toPoint: CGPoint) {
            let line = KGLine(startPoint: fromPoint, endPoint: toPoint)
            delegate?.kgConvexHullScanAlgorithm(self, didAddLine: line)
            lines.append(line)
        }
        
        func requestRemovalOfMiddleOfLastThreePointLines() {
            delegate?.kgConvexHullScanAlgorithm(self, didRemoveLine: lines.last!)
            lines.removeLast()
            
            delegate?.kgConvexHullScanAlgorithm(self, didRemoveLine: lines.last!)
            lines.removeLast()
        }
        
        // Compute upper hull by starting with leftmost two points.
        let upperHull = KGConvexHull(sortedPoints[0], sortedPoints[1])
        requestLineAddition(fromPoint: sortedPoints[0], toPoint: sortedPoints[1])
        for index in 2..<count {
            upperHull.add(point: sortedPoints[index])
            requestLineAddition(fromPoint: upperHull.points[upperHull.hullPointsCount - 2], toPoint: upperHull.points[upperHull.hullPointsCount - 1])
            
            while upperHull.hasThree, upperHull.areLastThreeNonRight {
                upperHull.removeMiddleOfLastThree()
                requestRemovalOfMiddleOfLastThreePointLines()
                requestLineAddition(fromPoint: upperHull.points[upperHull.hullPointsCount - 2], toPoint: upperHull.points[upperHull.hullPointsCount - 1])
            }
        }
        
        // Compute lower hull by starting with rightmost two points
        let lowerHull = KGConvexHull(sortedPoints[count - 1], sortedPoints[count - 2])
        requestLineAddition(fromPoint: sortedPoints[count - 1], toPoint: sortedPoints[count - 2])
        for index in (0...(count - 3)).reversed() {
            lowerHull.add(point: sortedPoints[index])
            requestLineAddition(fromPoint: lowerHull.points[lowerHull.hullPointsCount - 2], toPoint: lowerHull.points[lowerHull.hullPointsCount - 1])
            
            while lowerHull.hasThree, lowerHull.areLastThreeNonRight {
                lowerHull.removeMiddleOfLastThree()
                requestRemovalOfMiddleOfLastThreePointLines()
                requestLineAddition(fromPoint: lowerHull.points[lowerHull.hullPointsCount - 2], toPoint: lowerHull.points[lowerHull.hullPointsCount - 1])
            }
        }
        
        // Remove duplicate end points when combining.
        let hullConexPoints = upperHull.mergePoints(with: lowerHull)
        
        return hullConexPoints
    }
}

protocol KGConvexHullScanAlgorithmDelegate: class {
    
    func kgConvexHullScanAlgorithm(_ algorithm: KGConvexHullScanAlgorithm, didAddLine line: KGLine)
    
    func kgConvexHullScanAlgorithm(_ algorithm: KGConvexHullScanAlgorithm, didRemoveLine line: KGLine)
}
