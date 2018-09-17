//
//  RadialGradientLayer.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 9/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A layer that draws a radial color gradient over its background color.
public class RadialGradientLayer: CALayer {
    
    // MARK: - Properties
    
    private let startCenter: CGPoint
    private let endCenter: CGPoint
    private let startRadius: CGFloat
    private let endRadius: CGFloat
    private let colors: [CGColor]
    private let locations: [CGFloat]
    
    // MARK: - Initialization
    
    /// Initializes a new `RadialGradientLayer` object.
    ///
    /// - Parameters:
    ///   - startCenter: The coordinate that defines the center of the starting circle.
    ///   - endCenter: The coordinate that defines the center of the ending circle.
    ///   - startRadius: The radius of the starting circle.
    ///   - endRadius: The radius of the ending circle.
    ///   - colors: The colors array for rendering the gradient.
    ///   - locations: The location array for each color provided in colors; each location must be a CGFloat value in the range of 0 to 1, inclusive.
    public required init(startCenter: CGPoint, endCenter: CGPoint, startRadius: CGFloat, endRadius: CGFloat, colors: [CGColor], locations: [CGFloat] = [0.0, 1.0]) {
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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Draw methods
    
    /// Draws radial gradient by default.
    override public func draw(in ctx: CGContext) {
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
