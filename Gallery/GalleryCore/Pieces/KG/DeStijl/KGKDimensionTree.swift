//
//  KGKDimensionTree.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGKDimensionTree {
    
    // MARK: - Properties
    
    private var root: KGKDimensionNode?
    private var points: [CGPoint]!
    private var maxDimension: Int!
    
    private(set) var actionBuffer = [KKGKDimensionTreeNodeAction]()
    private var actionIndex = 0
    
    // MARK: - Initialization
    
    /// Recursively construct kd tree using median methods on input point.
    init(maxDimension: Int, from points: [CGPoint]) {
        guard !points.isEmpty else {
            NSLog("0 points.")
            return
        }
        
        self.maxDimension = maxDimension
        self.points = points
        
        guard let rootNode = generateKDNode(dimension: 1, left: 0, right: points.count - 1) else {
            NSLog("No node available.")
            return
        }
        
        self.root = rootNode
    }

    // MARK: - KD node initialization
    
    /// KDNode recursive genration for the KDTree.
    private func generateKDNode(dimension: Int, left: Int, right: Int) -> KGKDimensionNode? {
        guard right >= left else {
            NSLog("Wrong range - right < left")
            return nil
        }
        
        if right == left {
            let node = KGKDimensionNode(dimension: dimension, point: points[left])
            nodeAdditionAction(for: node)
            return node
        }
        
        // Order the array of points so the mth element will be the median and the elements prior to it will be all <=, though they won't be sorted; similarly, the elements after will be all >=.
        let medium = 1 + (right - left) / 2
        
        let algorithm = KGQuicksortSortingAlgorithm(sortingArray: points, dimension: dimension)
        algorithm.select(mediumIndex: medium, leftIndex: left, rightIndex: right)
        points = algorithm.sortingArray
        
        // Median point becomes the parent.
        let parentNode = KGKDimensionNode(dimension: dimension, point: points[left + medium - 1])
        nodeAdditionAction(for: parentNode)
        
        // Update the next dimesnion or reset back to 1.
        
        var updatedDimension = dimension + 1
        if updatedDimension > maxDimension {
            updatedDimension = 1
        }
        
        if let rightNode = generateKDNode(dimension: updatedDimension, left: left + medium, right: right) {
            rightNode.update(parent: parentNode)
            parentNode.update(right: rightNode)
        }
        
        if let leftNode = generateKDNode(dimension: updatedDimension, left: left, right: left + medium - 2) {
            leftNode.update(parent: parentNode)
            parentNode.update(left: leftNode)
        }
        
        return parentNode
    }
    
    private func nodeAdditionAction(for node: KGKDimensionNode) {
        let action = KKGKDimensionTreeNodeAction(node: node, index: actionIndex)
        actionBuffer.append(action)
        actionIndex += 1
    }
}
