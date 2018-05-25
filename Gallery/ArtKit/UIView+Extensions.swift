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
    
}
