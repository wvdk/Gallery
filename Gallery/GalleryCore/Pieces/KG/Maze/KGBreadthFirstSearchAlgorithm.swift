//
//  KGBreadthFirstSearchAlgorithm.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/5/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// Breadth-first search algorithm for specified vertex array.
class KGBreadthFirstSearchAlgorithm {
 
    // MARK: - Properties
    
    weak var delegate: KGBreadthFirstSearchAlgorithmDelegate? = nil
    
    private var size = KGVertexListSize()
    
    // MARK: - Vertex list item management
    
    /// Generates new list or vertex based on Breadth-first search algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list to be searched.
    ///     - size: Vertex list size in columns and rows.
    func search(in vertexList: [KGVertex], size: KGVertexListSize) -> [KGVertex] {
        self.size = size
        let index = KGVertex.startIndex(for: vertexList)
        return Bool.random() ? updateVertex(at: index, in: vertexList) : searchMinimumSpanningTree(for: index, in: vertexList)
    }
    
    /// Udpdates vertex list based on specified verex position in vertex node system using Breadth-first search algorithm.
    ///
    /// - Parameters:
    ///     - index: Index of specified vertex.
    ///     - vertexList: Vertex list to be searched.
    private func updateVertex(at index: Int, in vertexList: [KGVertex]) -> [KGVertex] {
        guard vertexList[index].stateColor != .black else {
            return vertexList
        }
        
        var roundCount = 0

        if vertexList[index].stateColor == .white {
            vertexList[index].stateColor = .gray
        }
        
        var queue = KGQueue<KGVertex>()
        queue.push(vertexList[index])
        
        while !queue.isEmpty, roundCount < 70 {
            let neighbourList = queue.first!.availableNeighbourVertexList(in: vertexList, with: size)
            
            neighbourList.forEach {
                $0.predecessorIndex = queue.first!.index
                $0.stateColor = .gray
                queue.push($0)
                
                delegate?.breadthFirstSearchAlgorithm(self, didUpdate: $0)
                roundCount += 1
            }
            
            queue.pop()
            vertexList[index].stateColor = .black
        }
        
        return vertexList
    }
    
    
    /// Searches for minimum spanning tree path in vertex list.
    ///
    /// - Parameters:
    ///     - index: Index of specified initial vertex.
    ///     - vertexList: Vertex list to be searched.
    private func searchMinimumSpanningTree(for index: Int, in vertexList: [KGVertex]) -> [KGVertex] {
        var queue = KGQueue<KGVertex>()
        var roundCount = 0
        
        // Set source vertex distance to 0.
        vertexList[index].distance = 0
        vertexList[index].stateColor = .gray
        
        queue.push(vertexList[index])
        
        // Finds vertex in ever-shrinking set, whose distance is smallest.
        // Recomputes potential new paths to update allshortest paths.
        while !queue.isEmpty, roundCount < 70  {
            let smallestDistanceVertex = queue.smallest!
            smallestDistanceVertex.stateColor = .black
            queue.pop(vertex: smallestDistanceVertex)
            
            let neighbourList = smallestDistanceVertex.availableNeighbourVertexList(in: vertexList, with: size)
            neighbourList.forEach {
                $0.stateColor = .gray
                queue.push($0)
                
                // Weight/distance to neighbour vertex nodes is equal to neighbour vertex index difference.
                let weight = ($0.index - smallestDistanceVertex.index)
                
                if weight < $0.distance {
                    $0.distance = weight
                    $0.predecessorIndex = smallestDistanceVertex.index
                    
                    delegate?.breadthFirstSearchAlgorithm(self, didUpdate: $0)
                    roundCount += 1
                }
            }
        }
        
        return vertexList
    }
}

/// The object that acts as the delegate of the `BreadthFirstSearchAlgorithm`.
///
/// The delegate must adopt the BreadthFirstSearchAlgorithmDelegate protocol.
///
/// The delegate object is responsible for managing the vertex update.
protocol KGBreadthFirstSearchAlgorithmDelegate: class {
    
    /// Tells the delegate that vertex was updated.
    ///
    /// - Parameters:
    ///     - algorithm: An object of the BreadthFirstSearchAlgorithm.
    ///     - vertex: A vertex node to be updated.
    func breadthFirstSearchAlgorithm(_ algorithm: KGBreadthFirstSearchAlgorithm, didUpdate vertex: KGVertex)
}
