//
//  UIView+Extensions.swift
//  ArtKit
//
//  Created by Wesley Van der Klomp on 3/15/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addSingleTapGestureRecognizer(_ action: @escaping (UITapGestureRecognizer) -> Void) {
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizerWithClosure(closure: action))
    }
    
    /// Sets constraints to the `view`, by default `constant` is 0.
    public func constraint(edgesTo view: UIView, constant: CGFloat = 0) {
        var constraints = [NSLayoutConstraint]()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant))
        constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant))
        constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant))
        constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant))
        
        NSLayoutConstraint.activate(constraints)        
    }
    
    /// Sets constraints to the `view`, by default `constant` is 0.
    public func constraint(edgesTo view: UIView, edgeInset: UIEdgeInsets) {
        var constraints = [NSLayoutConstraint]()
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: edgeInset.left))
        constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -edgeInset.right))
        constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: edgeInset.top))
        constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -edgeInset.bottom))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Configure a UIView to completely fill its parent, minus any edge insets
    ///
    /// - Parameters:
    ///   - parent: the UIView that the view should fill
    ///   - edgeInsets: the amounts around each edge to inset the view by
    public func autolayoutFill(parent: UIView, edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.leftAnchor.constraint(equalTo: parent.leftAnchor, constant: edgeInsets.left),
            self.rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -edgeInsets.right),
            self.topAnchor.constraint(equalTo: parent.topAnchor, constant: edgeInsets.top),
            self.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -edgeInsets.bottom)]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
}

// MARK: - Looping methods
extension UIView {
    
    /// The transformation options you can pass in a UIView loopInSuperView function. Uses associated values for specifiying the amounts of transformation you'd like (usually in points, if not otherwise specified).
    ///
    /// TODO: Add a scale and opacity options
    public enum LoopingOptions {
        
        /// Move each view horizontally from the previous view by the provided CGFloat.
        case moveHorizontallyWithIncrement(CGFloat)
        
        /// Move each view vertically from the previous view by the provided CGFLoat.
        case moveVerticallyWithIncrement(CGFloat)
        
        /// Rotate each view clockwise by degrees. Note: The CGFloat is 0.0-1.0, not 0-360.
        case rotateByDegrees(CGFloat)
        
        /// Changes the alpha value of the view randomly between 0.1 and 1.0.
        case updateOpacityRandomly
        
        /// Changes the alpha value of the view from 0.1 to 1.0.
        case updateOpacityIncreasingly        
    }
    
    /// Creates a copy of the UIView.
    ///
    /// Note: Might cause some issues with your subclasses of UIView if they don't handle being archived with NSKeyedArchiver.
    private func copyView<T: UIView>() -> T {
        let data = try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
        return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as! T
    }
    
    /// Creates a bunch of copies of the view, additively applying a transformation to them based on the `options` provided.
    ///
    /// - Parameters:
    ///   - duplicationCount: The number of additional views you want to be created.
    ///   - options: The transformation settings you want to be applied to each view.
    ///
    /// TODO: Add a scale and opacity options
    public func loopInSuperview(duplicationCount: Int, with options: [LoopingOptions]) {
        /// We start with an index of 2 - which seems weird but if very deliberate. If we use a starting index of 0, then multiply the origin points by that 0 index, it would bring the new view to the top left corner. Similarly if we start with 1, it will cover the original view.
        let startingIndex = 2
        let endingIndex = duplicationCount + startingIndex
        
        var currentRotationValue: CGFloat = 0.0
        
        for i in startingIndex..<endingIndex {
            // Duplicate original view
            let newView = self.copyView()
            self.superview?.addSubview(newView)
            newView.layer.borderWidth = layer.borderWidth
            newView.layer.borderColor = layer.borderColor
            
            // Apply transoforms based on options
            for option in options {
                switch option {
                case .moveVerticallyWithIncrement(let yMovement):
                    let newTransform = CGAffineTransform(translationX: 0, y: yMovement * CGFloat(i - 1))
                    newView.transform = newView.transform.concatenating(newTransform)
                case .moveHorizontallyWithIncrement(let xMovement):
                    let newTransform = CGAffineTransform(translationX: xMovement * CGFloat(i - 1), y: 0)
                    newView.transform = newView.transform.concatenating(newTransform)
                case .rotateByDegrees(let rotation):
                    let newTransoform = CGAffineTransform(rotationAngle: rotation + currentRotationValue)
                    
                    newView.transform = newView.transform.concatenating(newTransoform)
                    
                    currentRotationValue += rotation
                case .updateOpacityRandomly:
                    newView.alpha = CGFloat.random(in: 0...0.9) + 0.1
                    
                case .updateOpacityIncreasingly:
                    newView.alpha = CGFloat(0.1 + 0.9 * Double(i - startingIndex) / Double(duplicationCount))
                }
            }
        }
    }
}
