//
//  KGLineLayer.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGLineLayer: CAShapeLayer {
    
    private(set) var uuid: String!
    
    /// Opacity is set to 0.
    convenience init(from path: CGPath, color: CGColor = UIColor.white.cgColor, with uuid: String) {
        self.init()
        
        self.uuid = uuid
        
        self.path = path
        self.strokeColor = color
        self.lineWidth = 1
        self.opacity = 0
    }
}
