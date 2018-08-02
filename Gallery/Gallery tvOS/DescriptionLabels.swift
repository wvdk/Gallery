//
//  DescriptionLabel.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class BodyLabel: UILabel {
    
    convenience init(color: UIColor = .gray) {
        self.init(frame: .zero)

        self.textColor = color
        self.font = UIFont.systemFont(ofSize: 20)
    }
}

class HeadlineLabel: UILabel {
    
    convenience init(isFontBold: Bool) {
        self.init(frame: .zero)
        
        self.textColor = .gray
        
        if isFontBold {
            self.font = UIFont.boldSystemFont(ofSize: 30)
        } else {
            self.font = UIFont.systemFont(ofSize: 30)
        }
    }
}
