//
//  DescriptionLabel.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UILabel`.
///
/// Returns label with default text parameters:
/// - System font
/// - 20 size
/// - Gray color.
class BodyLabel: UILabel {
    
    /// Return `UILabel`.
    ///
    /// - Parameters:
    ///     - color: Text color, by default - gray.
    convenience init(color: UIColor = .gray) {
        self.init(frame: .zero)

        textColor = color
        font = UIFont.systemFont(ofSize: 20)
        
        numberOfLines = 0
        textAlignment = .justified
    }
}

/// A subclass of `UILabel`.
///
/// Returns label with default text parameters:
/// - System font
/// - 30 size
/// - Gray color.
class HeadlineLabel: UILabel {
    
    /// Return `UILabel`.
    ///
    /// - Parameters:
    ///     - color: Text color, by default - gray.
    ///     - isFontBold: Sets font bold property.
    convenience init(color: UIColor = .gray, isFontBold: Bool) {
        self.init(frame: .zero)
        
        textColor = color
        
        if isFontBold {
            font = UIFont.boldSystemFont(ofSize: 30)
        } else {
            font = UIFont.systemFont(ofSize: 30)
        }
    }
}
