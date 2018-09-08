//
//  CGFloat+Extension.swift
//  ArtKit iOS
//
//  Created by Kristina Gelzinyte on 9/7/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension CGFloat {
    
    /// Returns random number from the range.
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
    
    /// Returns a random floating point number between 0.0 and 1.0.
    public static var random: CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    /// Returns a normalized to specified value.
    public func normalize(to value: CGFloat) -> CGFloat {
        return self / value
    }
}
