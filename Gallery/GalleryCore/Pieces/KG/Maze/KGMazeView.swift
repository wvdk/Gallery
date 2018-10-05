//
//  KGMazeView.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/2/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class KGMazeView: UIView {
    
    // MARK: - Properties

    private let containerView = UIView()
    private let margin: CGFloat = 150.0

    
    private var lines = [KGLine]()
    
    // MARK: - Initialization
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(r: 0, g: 26, b: 40)
        
        addSubview(containerView)
        containerView.constraint(edgesTo: self)
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
