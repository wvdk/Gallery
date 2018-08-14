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
        
        constraints.append(self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant))
        constraints.append(self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant))
        constraints.append(self.topAnchor.constraint(equalTo: view.topAnchor, constant: constant))
        constraints.append(self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant))
        
        NSLayoutConstraint.activate(constraints)        
    }
}
