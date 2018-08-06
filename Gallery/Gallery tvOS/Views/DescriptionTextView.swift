//
//  DescriptionTextView.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A vertically acrollable multiline text region.
///
/// Defautl settings:
/// - White text color
/// - Justified text alligment
class DescriptionTextView: UITextView {

    // MARK: - Initialization
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        font = UIFont.systemFont(ofSize: 20)
        textColor = .white
        textAlignment = .justified
        
        isUserInteractionEnabled = true
        panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouchType.indirect.rawValue)]

        indicatorStyle = .white
        
        isScrollEnabled = true
        showsVerticalScrollIndicator = true
        showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
