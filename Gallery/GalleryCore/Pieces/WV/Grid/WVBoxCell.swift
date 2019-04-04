//
//  WVBoxCell.swift
//  Gallery iOS
//
//  Created by Wesley Van der Klomp on 4/3/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SceneKit

public class WVBoxCell: WVGridCell {
    
    public convenience init(boxSize: CGFloat) {
        self.init()
        
        self.geometry = SCNBox(width: boxSize,
                               height: boxSize,
                               length: boxSize,
                               chamferRadius: 0.0)
        
        self.runAction(
            SCNAction.repeatForever(
                SCNAction.sequence([
                    SCNAction.wait(duration: 0.5),
                    SCNAction.run { [weak self] node in
                        self?.refreshColors()
                    }
                    ])
            )
        )
    }
    
    public var availableColors: [UIColor] = []
    
    private func refreshColors() {
        geometry?.firstMaterial?.diffuse.contents = availableColors.randomElement()
    }
    
}
