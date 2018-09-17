//
//  UIImage+Extension.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Creates an image by rendering specified layer.
    ///
    /// - Parameters:
    ///     - layer: The layer used to render image.
    ///     - size: An image size.
    public class func render(from layer: CALayer, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            return layer.render(in: context.cgContext)
        }
        
        return image
    }
}
