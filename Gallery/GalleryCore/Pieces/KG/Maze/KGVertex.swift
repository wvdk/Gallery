//
//  KGVertex.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/5/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A node object which contains properties to define its position and state in node system.
class KGVertex {
    
    /// The index of the previous in line vertex node.
    var predecessorIndex = -1
    /// The index of current vertex node.
    var index: Int
    /// The size of current vertex node parent.
    var size: KGVertexListSize
    /// The distance to the source vertex node.
    var distance = Int.max
    /// The state defined by color of current vertex node.
    var stateColor = KGVertexStateColor.white
    /// The vertex node property set to true id it needs to be ignored in algortithm.
    var isIgnored = false
    
    /// Returns a vertex node.
    ///
    /// - Parameters:
    ///     - index: Unique index for the vertex node.
    init(index: Int, in size: KGVertexListSize) {
        self.index = index
        self.size = size
    }
    
    /// Returns start index for algorithm.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list of specifeid vertex.
    static func startIndex(for vertexList: [KGVertex]) -> Int {
        var startIndex = Int.random(in: 0...(vertexList.count - 1))
//        var startIndex = vertexList.count / 2
        
        while !vertexList[startIndex].isIgnored {
            startIndex = Int.random(in: 0...(vertexList.count - 1))
        }
        
        return startIndex
    }
    
    /// Returns next in line neighbour vertex nodes.
    ///
    /// - Parameters:
    ///     - vertexList: Vertex list of specifeid vertex.
    ///     - size: Vertex list size.
    func availableNeighbourVertexList(in vertexList: [KGVertex], with size: KGVertexListSize) -> [KGVertex] {
        let range = 0...(vertexList.count - 1)
        var neighbourVertexList = [KGVertex]()
        
        // Randomizing neighbour vertex sequence to create patters.
        let randomDirections = KGVertexDirection.randomDirections
        randomDirections.forEach { direciton in
            switch direciton {
            case .left:
                if index == 0 || index % size.columns == 0 { break }
                
                let leftIndex = index - 1
                if range.contains(leftIndex), vertexList[leftIndex].stateColor == .white, !vertexList[leftIndex].isIgnored {
                    neighbourVertexList.append(vertexList[leftIndex])
                }
            case .right:
                let rightIndex = index + 1
                if rightIndex >= size.columns, rightIndex % size.columns == 0 { break }
                
                if range.contains(rightIndex), vertexList[rightIndex].stateColor == .white, !vertexList[rightIndex].isIgnored {
                    neighbourVertexList.append(vertexList[rightIndex])
                }
                
            case .up:
                let upIndex = index + size.columns
                if range.contains(upIndex), vertexList[upIndex].stateColor == .white, !vertexList[upIndex].isIgnored {
                    neighbourVertexList.append(vertexList[upIndex])
                }
                
            case .down:
                let downIndex = index - size.columns
                if range.contains(downIndex), vertexList[downIndex].stateColor == .white, !vertexList[downIndex].isIgnored {
                    neighbourVertexList.append(vertexList[downIndex])
                }
            }
        }
        
        return neighbourVertexList
    }
    
    /// Returns a KGLine type vertex line.
    ///
    /// - Parameters:
    ///     - frame: Parent's view vertex is about to be draw in.
    ///     - cellSize: The size of the maze cell.
    func line(in frame: CGRect, cellSize: CGFloat) -> KGLine {
        let cellRow = (Double(index) / Double(size.columns)).rounded(.down)
        let cellColumn = Double(index) - cellRow * Double(size.columns)
        
        let predecessorCellRow = (Double(predecessorIndex) / Double(size.columns)).rounded(.down)
        let predecessorCellColumn = Double(predecessorIndex) - predecessorCellRow * Double(size.columns)
        
        let startPoint = CGPoint(x: Double(cellSize) * ( 0.5 + cellColumn), y: Double(cellSize) * ( 0.5 + cellRow)).add(point: frame.origin)
        let endPoint = CGPoint(x: Double(cellSize) * ( 0.5 + predecessorCellColumn), y: Double(cellSize) * ( 0.5 + predecessorCellRow)).add(point: frame.origin)
        
        let line = KGLine(startPoint: startPoint, endPoint: endPoint)
        return line
    }
}

extension KGVertex: Equatable {
    
    static func == (lhs: KGVertex, rhs: KGVertex) -> Bool {
        return lhs.index == rhs.index
    }
}

extension CGPoint {
    
    func add(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + point.x, y: self.y + point.y)
    }
}


/// Size of vertex list object as a matrix.
struct KGVertexListSize {
    
    /// Column number.
    var columns: Int
    /// Row number.
    var rows: Int
    
    /// Returns a vertex list size object.
    ///
    /// - Parameters:
    ///     - columns: Number of columns.
    ///     - rows: Number of rows.
    init(columns: Int = 4, rows: Int = 4) {
        self.columns = columns
        self.rows = rows
    }
}

/// Vertex state types defines by color.
enum KGVertexStateColor {
    
    /// Vertex has not been visited yet.
    case white
    /// Vertex has been visited, but it may have adjacent vertex that has been not.
    case gray
    /// Vertex has been visited and so all its adjacent vertices.
    case black
}

/// Direction type to the new vertex.
///
/// List of possible directions:
/// - up
/// - down
/// - left
/// - right
enum KGVertexDirection: Int {
    
    case up = 1
    case down = 2
    case left = 3
    case right = 4
    
    /// Returns a random direction from all possible directions.
    static var random: KGVertexDirection {
        let randomInt = (Int(arc4random_uniform(4)) + 1);
        return KGVertexDirection.init(rawValue: randomInt) ?? .up
    }
    
    /// Returns a random direction list from all possible (4) directions.
    static var randomDirections: [KGVertexDirection] {
        var directions = [KGVertexDirection]()
        
        while directions.count < 4 {
            let direction = KGVertexDirection.random
            
            if !directions.contains(direction) {
                directions.append(direction)
            }
        }
        
        return directions
    }
}
