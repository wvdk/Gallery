//
//  Boid.swift
//  GalleryCore iOS
//
//  Created by Wesley Van der Klomp on 8/28/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import Foundation

/// A Boid.
struct Boid {
    
    // A 0 to 360 value indicating the direction this boid is moving.
    let direction: Double
    
    /// The current point at which this boid is located.
    let position: CGPoint
    
}
