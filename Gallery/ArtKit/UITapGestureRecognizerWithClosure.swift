//
//  UITapGestureRecognizerWithClosure.swift
//  ArtKit
//
//  Created by Wesley Van der Klomp on 3/15/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

public class UITapGestureRecognizerWithClosure: UITapGestureRecognizer {
    
    private let closure: (UITapGestureRecognizer) -> ()
    
    public init(closure: @escaping (UITapGestureRecognizer) -> ()) {
        self.closure = closure
        super.init(target: nil, action: nil)
        self.addTarget(self, action: #selector(UITapGestureRecognizerWithClosure.invokeTarget(_:)))
    }

    @objc func invokeTarget(_ recognizer: UITapGestureRecognizer) {
        self.closure(recognizer)
    }
    
}
