//
//  FeaturedArtPieceCollectionViewCell+FocusingViewDelegate.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/2/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension FeaturedArtPieceCollectionViewCell: FocusingViewDelegate {
    
    func focusingViewDidBecomeFocused(_ focusingView: FocusingView) {
        showArtPiece()
    }
    
    func focusingViewDidResignedFocus(_ focusingView: FocusingView) {
        hideArtPiece()
    }
}
