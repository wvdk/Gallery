//
//  SKTexture+Extension.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/17/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import SpriteKit

extension SKTexture {
    
    /// Create a new texture object from a layer object.
    ///
    /// - Parameters:
    ///     - layer: The layer used to create texture.
    ///     - size: The texture size.
    public convenience init(layer: CALayer, size: CGSize) {
        let image = UIImage.render(from: layer, size: size)
        self.init(image: image)
    }
}
