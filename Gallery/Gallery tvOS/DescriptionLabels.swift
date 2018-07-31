//
//  DescriptionLabel.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/30/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class BodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.textColor = .gray
        self.font = UIFont.systemFont(ofSize: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
