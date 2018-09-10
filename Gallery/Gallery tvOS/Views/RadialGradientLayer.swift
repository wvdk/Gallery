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
    
    private let startCenter: CGPoint
    private let endCenter: CGPoint
    private let startRadius: CGFloat
    private let endRadius: CGFloat
    private let colors: [CGColor]
    private let locations: [CGFloat]
    
    // MARK: - Initialization
    
    required init(startCenter: CGPoint, endCenter: CGPoint, startRadius: CGFloat, endRadius: CGFloat, colors: [CGColor], locations: [CGFloat] = [0.0, 1.0]) {
        self.startCenter = startCenter
        self.endCenter = endCenter
        self.startRadius = startRadius
        self.endRadius = endRadius
        self.colors = colors
        self.locations = locations
        
        super.init()
        
        needsDisplayOnBoundsChange = true
        setNeedsDisplay()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Draw methods
    
    /// Draws radial gradient by default.
    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: locations) else { return }
        
        ctx.drawRadialGradient(gradient,
                               startCenter: startCenter,
                               startRadius: startRadius,
                               endCenter: endCenter,
                               endRadius: endRadius,
                               options: CGGradientDrawingOptions(rawValue: 0))
        
        ctx.restoreGState()
    }
}
