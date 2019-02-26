//
//  KGDeStijlController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGDeStijlController {
    
    static func actions(forPointCount: Int, in rect: CGRect) -> [KGLineDrawingAction] {
        var points = [CGPoint]()
        
        for _ in 1...forPointCount {
            let newPoint = CGPoint(x: CGFloat.random(in: rect.minX...rect.maxX).rounded(), y: CGFloat.random(in: rect.minY...rect.maxY).rounded())
            points.append(newPoint)
        }
        
        let tree = KGKDimensionTree(maxDimension: 2, from: points)
        let actions = tree.actionBuffer.map { return KGLineDrawingAction(line: $0.node.line(in: rect), type: .addition, index: $0.index) }
        return actions
    }
    
    static func frames(for actions: [KGLineDrawingAction], maxCount: Int) -> [CGRect] {
        var points = [CGPoint]()
        actions.forEach { points.append(contentsOf: [$0.line.startPoint, $0.line.endPoint]) }
        
        var frames = [CGRect]()
        
        for point in points.shuffled() {
            guard frames.count < maxCount else {
                return frames
            }
            
            let sameYPoints = points.filter { $0.x != point.x && $0.y == point.y }
            let sameYPoint = sameYPoints.min { a, b -> Bool in
                return a.distance(to: point) < b.distance(to: point)
            }
            
            guard sameYPoint != nil else {
                continue
            }
            
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
            
            guard anotherYPoint != nil else {
                continue
            }
            
            let rect = CGRect.make(point, anotherYPoint!)
            if frames.contains(rect) {
                continue
            }
            
            frames.append(rect)
        }
        
        return frames
    }
}
