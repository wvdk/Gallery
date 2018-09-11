//
//  KGBoidProperties.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

/// The boid property list you can pass in a KGBoidNode init function.
/// Uses associated values to specifie values.
enum KGBoidProperties {
    
    /// Creats trace particle every specified time interval in sec of type `CGFloat`.
    case leavesTranceParticlesEverySec(CGFloat)
    
    /// Sets boid stroke color to specified one.
    case strokeColor(UIColor)
    
    /// Sets boid color to specified one.
    case fillColor(UIColor)
    
    /// Sets boids shape to specified one.
    case customShape(CGPath)
}
