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
    private var actions = [[KGSortingAction]]()
    private var boxes = [[CALayer]]()
    
    private var maxRowActionCount = 0
    private var columnActionCount = 0

    private var duration: Double {
        return reverse ? 0.16 : 0.13
    }
    
    override init(frame: CGRect) {
        pixelSize = frame.size == UIScreen.main.bounds.size ? 15.0 : 10.0
        columns = Int(frame.width / pixelSize)
        rows = Int(frame.height / pixelSize)
        
        super.init(frame: frame)

        backgroundColor = .black
        
        let size = MatrixSize(columns: columns, rows: rows)
        let sortingController = KGInsertionSortingController(sortingMatrixSize: size)
        
        actions = sortingController.sortingActions
        columnActionCount = actions.count
        maxRowActionCount = sortingController.maximumActionCount
        
        setupGraph(for: sortingController.unsortedArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Could not load")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard newSuperview != nil else {
            return
        }
        
        performSorting()
    }
    
    private func setupGraph(for unsortedArray: [[Int]]) {
        var deltaOriginX: CGFloat = 0.0
        
        unsortedArray.forEach { columnActions in
            var rowBoxes = [CALayer]()
            
            for (rowIndex, rowActions) in columnActions.enumerated() {
                let box = CALayer()
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
    
    private func gradientColor(for index: CGFloat) -> UIColor {
        let color1 = Color(r: 0, g: 168, b: 255)
        let color2 = Color(r: 0, g: 0, b: 0)
        return Color.gradientColor(color1, color2, percentage: index)
    }
    
    private func performSorting() {
        let timeConstant = reverse ? 0.3 : 0
        
        for rowIndex in 0..<maxRowActionCount {
            Timer.scheduledTimer(withTimeInterval: Double(rowIndex) * duration + timeConstant, repeats: false) { [weak self] _ in
                guard let self = self else {
                    return
                }

                for columnIndex in 0..<self.columnActionCount {
                    guard self.actions[columnIndex].count > rowIndex else {
                        continue
                    }
                    
                    let columnActions = self.reverse ? self.actions[columnIndex] : self.actions[columnIndex].reversed()
                    let action = columnActions[rowIndex]
                    self.swapElements(action.start, action.end, at: columnIndex)
                }
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: Double(maxRowActionCount) * duration, repeats: false) { [weak self] _ in
            self?.performSorting()
        }
        
        reverse = !reverse
    }

    private func swapElements(_ i: Int, _ j: Int, at column: Int) {
        let elements = boxes[column].filter { $0.name == "\(i)" || $0.name == "\(j)" }
        
        guard let iElement = elements.first(where: { $0.name == "\(i)" }), let jElement = elements.first(where: { $0.name == "\(j)" }) else {
                return
        }
        
        iElement.name = "\(j)"
        jElement.name = "\(i)"
        
        let delta = i.distance(to: j)
        let iTranslation = pixelSize * CGFloat(delta)
        let jTranslation = -pixelSize * CGFloat(delta)
        
        iElement.position.y += iTranslation
        jElement.position.y += jTranslation
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
}
