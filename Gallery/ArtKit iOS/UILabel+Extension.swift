//
//  UILabel+Extension.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 7/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

extension UILabel {
    
    /// A Boolean value that determines whether the `UILabel` text is truncated.
    ///
    /// Label size must be known before calling this property.
    public var isTruncated: Bool {
        guard let labelText = text as NSString? else {
            return false
        }
        
        let labelTextSize = labelText.boundingRect(with: CGSize(width: frame.size.width,
                                                                height: .greatestFiniteMagnitude),
                                                   options: .usesLineFragmentOrigin,
                                                   attributes: [.font: font],
                                                   context: nil).size
        
        return labelTextSize.height > bounds.size.height
    }
}
