//
//  KGBoidProperties.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

/// The boid property list you can pass in a KGBoidNode init function.
/// Uses associated values to specifie values.
enum KGBoidProperties: Equatable {
    
    /// Creats trace particle after specified distance `CGFloat`.
    case leavesTranceBoidAtDistance(CGFloat)

    /// Sets boid stroke color to specified one.
    case strokeColor(UIColor)

    /// Sets boid color to specified one.
    case fillColor(UIColor)
    
    /// Set boids direction to upwards.
    case upDirection
    
    /// Set boids confinement frame.
    case confinementFrame(CGRect)
    
    /// Set initial direction direction for the boid.
    case initialDirection(CGVector)
}
