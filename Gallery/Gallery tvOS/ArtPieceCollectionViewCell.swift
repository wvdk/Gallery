//
//  ArtPieceCollectionViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ArtPieceCollectionViewCellIdentifier"
    
    let label: UILabel
    
    var myNumber: Int? {
        didSet {
            label.text = "\(myNumber)"
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        label = UILabel(frame: CGRect(origin: CGPoint(x: 100, y: 100),
                                      size: CGSize(width: 300, height: 300)))

        super.init(frame: frame)
        
        self.backgroundColor = .red
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        self.alpha = self.isFocused ? 1 : 0.5
    }
}
