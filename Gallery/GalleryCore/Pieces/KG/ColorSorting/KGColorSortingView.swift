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
    
    private var duration: Double {
        return reverse ? 0.07 : 0.05
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
        pixelSize = 30.0
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
        
        for (columnIndex, columnActions) in unsortedArray.enumerated() {
            for (rowIndex, rowActions) in columnActions.enumerated() {
                let box = ActionLayer()
                box.frame = CGRect(x: deltaOriginX, y: 0.0, width: pixelSize, height: pixelSize)
                box.position.y += CGFloat(rowIndex) * pixelSize
                box.backgroundColor = gradientColor(for: CGFloat(rowActions) / CGFloat(rows)).cgColor
                box.name = "\(columnIndex)+\(rowIndex)"
                layer.addSublayer(box)
            }
            
            deltaOriginX += pixelSize
        }
    }
    
    private func performSorting() {
        for (columnIndex, columnActions) in actions.enumerated() {
            let sortingActions = reverse ? columnActions.reversed() : columnActions
            let totalNumberOfAction = columnActions.count + 1
            
            sortingActions.forEach {
                let index = reverse ? totalNumberOfAction - $0.index : $0.index
                swapElements($0.start, $0.end, at: columnIndex, actionIndex: index)
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
        guard let iElement = subview(name: "\(column)+\(i)"), let jElement = subview(name: "\(column)+\(j)") else {
            return
        }
        
        iElement.name = "\(column)+\(j)"
        jElement.name = "\(column)+\(i)"
        
        let delta = i.distance(to: j)
        let iTranslation = pixelSize * CGFloat(delta)
        let jTranslation = -pixelSize * CGFloat(delta)
        
        iElement.moveAction(by: iTranslation, duration: duration, actionIndex: actionIndex)
        jElement.moveAction(by: jTranslation, duration: duration, actionIndex: actionIndex)
    }
    
    private func subview(name: String) -> ActionLayer? {
        guard let sublayers = layer.sublayers else {
            return nil
        }
        
        for layer in sublayers {
            if let actionLayer = layer as? ActionLayer, actionLayer.name == name {
                return actionLayer
            }
        }
        
        return nil
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
