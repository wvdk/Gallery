//
//  A565zView.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 6/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import SceneKit

#if os(iOS)
import ArtKit_iOS
#elseif os(tvOS)
import ArtKit_tvOS
#endif

public class A565zView: ArtView {

    public required init(frame: CGRect, artPieceMetadata: ArtMetadata) {
        super.init(frame: frame, artPieceMetadata: artPieceMetadata)
        
        backgroundColor = .white
        
        let box = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        addSubview(box)
        box.backgroundColor = .white
        box.layer.borderColor = UIColor.blue.cgColor
        box.layer.borderWidth = 1.0
        box.loopInSuperview(duplicationCount: 3, with: [UIView.LoopingOptions.moveHorizontallyWithIncrement(200)])
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
