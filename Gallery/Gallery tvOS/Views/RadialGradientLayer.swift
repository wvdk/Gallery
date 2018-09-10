//
//  RadialGradientLayer.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 9/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class RadialGradientLayer: CALayer {
    
    // MARK: - Properties
    
    /// The center of the radial gradient.
    var center: CGPoint {
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    /// The radius of the radial gradient.
    var radius = CGFloat(100) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// An array of locations for colors in radial gradient.
    var locations: [CGFloat] = [0.0, 1.0] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// An array of colors for radial gradient.
    var colors = [UIColor.black, UIColor.lightGray] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    /// Returns CGColor type representitive of `colors` array.
    private var cgColors: [CGColor] {
        return colors.map({ (color) -> CGColor in
            return color.cgColor
        })
    }
    
    // MARK: - Initialization
    
    override init() {
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Draw methods
    
    /// Draws radial gradient by default.
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: cgColors as CFArray, locations: locations) else { return }
        
        ctx.drawRadialGradient(gradient,
                               startCenter: center,
                               startRadius: 0.0,
                               endCenter: center,
                               endRadius: radius,
                               options: CGGradientDrawingOptions(rawValue: 0))
        
        ctx.restoreGState()
    }
}
