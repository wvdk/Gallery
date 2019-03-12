//
//  KGColorSortingView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/11/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import Foundation

class KGColorSortingView: UIView {
    
    private let pixelSize: CGFloat
    private let columns: Int
    private let rows: Int
    
    private var reverse = false
    private var actions = [[SortingAction]]()
    private var boxes = [[ActionLayer]]()
    
    private var duration: Double {
        return reverse ? 0.07 : 0.05
    }
    
    private var maxActionCount: Int {
        let maximum = actions.max { i, j -> Bool in
            i.count < j.count
        }
        
        guard maximum != nil else {
            return 0
        }
        
        return maximum!.count
    }
    
    private var deadline: Double {
        let maximum = actions.max { i, j -> Bool in
            i.count < j.count
        }
        
        guard maximum != nil else {
            return 0
        }
        
        return Double(maximum!.count) * duration + 0.4
    }
    
    override init(frame: CGRect) {
        pixelSize = 10.0
        columns = Int(frame.width / pixelSize)
        rows = Int(frame.height / pixelSize)
        
        super.init(frame: frame)

        backgroundColor = .black
        
        let size = MatrixSize(columns: columns, rows: rows)
        let sortingController = SortingController(sortingMatrixSize: size)
        
        actions = sortingController.sortingActions
        
        setupGraph(for: sortingController.unsortedArray)
        performSorting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Could not load")
    }
    
    private func setupGraph(for unsortedArray: [[Int]]) {
        var deltaOriginX: CGFloat = 0.0
        
        unsortedArray.forEach { columnActions in
            var rowBoxes = [ActionLayer]()
            for (rowIndex, rowActions) in columnActions.enumerated() {
                let box = ActionLayer()
                box.frame = CGRect(x: deltaOriginX, y: 0.0, width: pixelSize, height: pixelSize)
                box.position.y += CGFloat(rowIndex) * pixelSize
                box.backgroundColor = gradientColor(for: CGFloat(rowActions) / CGFloat(rows)).cgColor
                box.name = "\(rowIndex)"
                layer.addSublayer(box)
                
                rowBoxes.append(box)
            }
            
            boxes.append(rowBoxes)
            deltaOriginX += pixelSize
        }
    }
    
    private func performSorting() {
        for rowIndex in 0..<maxActionCount {
            for columnIndex in 0..<actions.count {
                
                if actions[columnIndex].count > rowIndex {
                    let action = actions[columnIndex][rowIndex]
                    swapElements(action.start, action.end, at: columnIndex, actionIndex: action.index)
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            self.performSorting()
        }
        
        reverse = !reverse
    }
    
    private func gradientColor(for index: CGFloat) -> UIColor {
        let color1 = Color(r: 255, g: 0, b: 0)
        let color2 = Color(r: 0, g: 0, b: 255)
        return Color.gradientColor(color1, color2, percentage: index)
    }
    
    private func swapElements(_ i: Int, _ j: Int, at column: Int, actionIndex: Int) {
        guard let iElement = layer(with: "\(i)", at: column), let jElement = layer(with: "\(j)", at: column) else {
            return
        }
        
        iElement.name = "\(j)"
        jElement.name = "\(i)"
        
        let delta = i.distance(to: j)
        let iTranslation = pixelSize * CGFloat(delta)
        let jTranslation = -pixelSize * CGFloat(delta)
        
        iElement.moveAction(by: iTranslation, duration: duration, actionIndex: actionIndex)
        jElement.moveAction(by: jTranslation, duration: duration, actionIndex: actionIndex)
    }
    
    private func layer(with name: String, at column: Int) -> ActionLayer? {
        return boxes[column].first { $0.name == name }
    }
    
    public struct MatrixSize {
        
        let columns: Int
        let rows: Int
    }
    
    struct Color {
        
        let r: CGFloat
        let g: CGFloat
        let b: CGFloat
        
        init(r: CGFloat, g: CGFloat, b: CGFloat) {
            self.r = r / 255
            self.g = g / 255
            self.b = b / 255
        }
        
        static func gradientColor(_ color1: Color, _ color2: Color, percentage: CGFloat) -> UIColor {
            let red = color1.r + (color2.r - color1.r) * percentage
            let green = color1.g + (color2.g - color1.g) * percentage
            let blue = color1.b + (color2.b - color1.b) * percentage
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }

    class ActionLayer: CALayer {
        
        func moveAction(by translationLength: CGFloat, duration: Double, actionIndex: Int) {
            Timer.scheduledTimer(withTimeInterval: Double(actionIndex) * duration, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                self.position.y += translationLength
            }
        }
    }
}
