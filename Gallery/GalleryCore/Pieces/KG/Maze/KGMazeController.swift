//
//  KGMazeController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/5/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGMazeController {
    
    // MARK: - Properties
    
    var mazeActions: [KGVertexDrawingAction] {
        return actionBuffer
    }
    
    private let algorithm = KGBreadthFirstSearchAlgorithm()
    private var vertexList = [KGVertex]()
    private var vertexObstacleIndexList = [Int]()
    private var size = KGVertexListSize(columns: 0, rows: 0)
    
    fileprivate(set) var actionBuffer = [KGVertexDrawingAction]()
    fileprivate var actionIndex = 0
    
    // MARK: - Initialization
    
    func setup(size: KGVertexListSize) {
        self.size = size
        
        reset()
        setupRawVertexList(hasIgnoredVertex: true)
        
        algorithm.delegate = self
    }
    
    private func reset() {
        actionIndex = 0
        actionBuffer = []
        vertexList = []
        vertexObstacleIndexList = []
    }
    
    // MARK: - Vertex list set up
    
    /// Initialized empty matrix of size: columns x rows.
    ///
    /// - Parameters:
    ///     - columns: Column number for the maze.
    ///     - rows: Row number for the maze.
    private func setupRawVertexList(hasIgnoredVertex: Bool = false) {
        let columns = size.columns
        let rows = size.rows
        let maxIndex = columns * rows
        
        for index in 0..<maxIndex {
            let vertex = KGVertex(index: index, in: size)
            vertexList.append(vertex)
        }
        
        if hasIgnoredVertex {
            var vertexObstacleIndexList = [Int]()
            let maxNumber = maxIndex / 5
            for _ in 0...maxNumber {
                let randomIndex = Int.random(in: 0...vertexList.count - 1)
                vertexObstacleIndexList.append(randomIndex)
                vertexList[randomIndex].isIgnored = true
            }
        }
    }
    
    // MARK: - Compute methods
    
    @discardableResult func compute() -> [KGVertex] {
        return algorithm.search(in: vertexList, size: size)
    }
}

extension KGMazeController: KGBreadthFirstSearchAlgorithmDelegate {
    
    // MARK: - BreadthFirstSearchAlgorithmDelegate implementation
    
    func breadthFirstSearchAlgorithm(_ algorithm: KGBreadthFirstSearchAlgorithm, didUpdate vertex: KGVertex) {
        let action = KGVertexDrawingAction(vertex: vertex, type: .addition, index: actionIndex)
        actionBuffer.append(action)
        actionIndex += 1
    }
}
