//
//  WVGridView.swift
//  Gallery iOS
//
//  Created by Wesley Van der Klomp on 4/3/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SceneKit

public typealias WVGridCell = SCNNode

protocol WVGridDelegate: class {
    
    func grid(_ grid: WVGrid, cellForIndex: IndexPath) -> WVGridCell
    
}


class WVMyGridDelegate: WVGridDelegate {
    
    func grid(_ grid: WVGrid, cellForIndex: IndexPath) -> WVGridCell {
        
        //        guard let index = grids.firstIndex(where: { $0 == grid }) else {
        //            fatalError()
        //        }
        //
        let boxCell = WVBoxCell(boxSize: grid.cellSize)
        boxCell.availableColors = [.white, .clear]
        return boxCell
    }
}

class WVGrid: Equatable {
    
    static func == (lhs: WVGrid, rhs: WVGrid) -> Bool {
        return lhs.cells == rhs.cells
    }
    
    public weak var delegate: WVGridDelegate? = nil
    
    /// A 2D array of containing 1. rows of cells, 2. the color of each cell.
    private var cells: [[WVGridCell]] = []
    
    private var numberOfRows: Int
    private var numberOfColumns: Int
    private var rootNode: SCNNode
    private var startingPosition: SCNVector3
    public var cellSize: CGFloat
    private var spacing: CGFloat
    
    public init(rows: Int, columns: Int, to rootNode: SCNNode, at startingPosition: SCNVector3, cellSize: CGFloat, spacing: CGFloat) {
        self.numberOfRows = rows
        self.numberOfColumns = columns
        self.rootNode = rootNode
        self.startingPosition = startingPosition
        self.cellSize = cellSize
        self.spacing = spacing
    }
    
    public func reload() {
        guard let delegate = delegate else {
            return
        }
        
        for rowNumber in 0..<numberOfRows {
            var row: [WVGridCell] = []
            for columnNumber in 0..<numberOfColumns {
                
                let newCell = delegate.grid(self, cellForIndex: IndexPath(row: rowNumber, section: columnNumber))
                
                newCell.position = SCNVector3(startingPosition.x + (Float(cellSize + spacing) * Float(columnNumber)),
                                              startingPosition.y + (Float(cellSize + spacing) * Float(rowNumber)),
                                              startingPosition.z + (Float(cellSize + spacing) * Float(0)))
                
                row.append(newCell)
                rootNode.addChildNode(newCell)
            }
            
            cells.append(row)
        }
    }
    
}

class WVGridView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let view = SCNView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height), options: nil)
        let scene = SCNScene()
        view.scene = scene
        view.backgroundColor = #colorLiteral(red: 0.9772096276, green: 0.9530881047, blue: 0.8845147491, alpha: 1)
        view.autoenablesDefaultLighting = true
        view.showsStatistics = true
        view.allowsCameraControl = false
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 50)
        scene.rootNode.addChildNode(cameraNode)
        
        let centerDot = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0.2)
        centerDot.materials.first?.diffuse.contents = UIColor.red
        let centerNode = SCNNode(geometry: centerDot)
        scene.rootNode.addChildNode(centerNode)
        centerNode.position = SCNVector3(0, 0, 0)
        
        let lookAtCenterNodeConstraint = SCNLookAtConstraint(target: centerNode)
        cameraNode.constraints = [lookAtCenterNodeConstraint]
        
//        let cameraPan = SCNAction.move(by: SCNVector3(20, 20, 0), duration: 10.0)
//        cameraNode.runAction(cameraPan)
        
        var grids: [WVGrid] = []

        let myGridDelegate = WVMyGridDelegate()
        
        for i in 0...1 {
            let newGrid = WVGrid(rows: 40,
                               columns: 60,
                               to: scene.rootNode,
                               at: SCNVector3(-60.0, -60.0, Double(i) * -1.2),
                               cellSize: 1.5,
                               spacing: 0.75)
            newGrid.delegate = myGridDelegate
            newGrid.reload()
            grids.append(newGrid)
        }
        
        addSubview(view)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
