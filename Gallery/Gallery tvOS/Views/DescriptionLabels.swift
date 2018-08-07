//
//  DescriptionLabel.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// `System` `font` 20 size text label. By default `gray` color.
class BodyLabel: UILabel {
    
    convenience init(color: UIColor = .gray) {
        self.init(frame: .zero)

        self.textColor = color
        self.font = UIFont.systemFont(ofSize: 20)
        
        self.numberOfLines = 0
        self.textAlignment = .justified
    }
}

/// `System` `font` 30 size `gray` color text label.
class HeadlineLabel: UILabel {
    
    convenience init(color: UIColor = .gray, isFontBold: Bool) {
        self.init(frame: .zero)
        
        self.textColor = color
        
        if isFontBold {
            self.font = UIFont.boldSystemFont(ofSize: 30)
        } else {
            self.font = UIFont.systemFont(ofSize: 30)
        }
    }
}
