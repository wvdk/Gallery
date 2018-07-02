//
//  UIColor+Extensions.swift
//  ArtKit
//
//  Created by Wesley Van der Klomp on 3/11/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

extension UIColor {

    /// Initialize a UIColor using RGB values between 0 and 255.
    public convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }

}
