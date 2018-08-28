//
//  BoidLand.swift
//  GalleryCore iOS
//
//  Created by Wesley Van der Klomp on 8/28/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import Foundation

/// A struct which holds the current frame state of a Boid enviroment - and can advance that state one frame at a time based on *the rules*.
struct BoidLand {
    
    private(set) var boids: [Boid] = []
    
    /// An ever increasing count of the frames rendered so far (in practice this means the number of times `advanceToNextFrame()` has been called).
    var frameNumber: Int = 0
    
    /// Updates the properties of each element in Boid Land by one from according to *the rules*.
    mutating func advanceToNextFrame() {
        frameNumber += 1
        
    }
    
    /// Adds a new boid to the enviroment.
    ///
    /// - Parameter position: The point at which you would like to place the new boid.
    mutating func addBoid(at position: CGPoint) {
        boids.append(Boid(direction: Double.random(in: 0.0...360.0), position: position))
    }
    
}
