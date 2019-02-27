//
//  LoopingLineView.swift
//  Gallery tvOS
//
//  Created by Kristina Gelzinyte on 9/10/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class LoopingLinesView: UIView {
    
    convenience init() {
        self.init(frame: .zero)
        
        let line = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 2, height: 500)))
        addSubview(line)
        
        line.transform = CGAffineTransform(rotationAngle: -.pi / 4)
        line.backgroundColor = UIColor(r: 255, g: 255, b: 255, alpha: 1)
        line.alpha = 0.05
        
        line.loopInSuperview(duplicationCount: 600, with: [
            .rotateByDegrees(-0.005),
            .moveHorizontallyWithIncrement(5),
            .updateOpacityIncreasingly
            ]
        )
    }
    
    func rotate() {
        for subview in subviews {
            subview.rotate(duration: 200.0)
        }
    }
}
