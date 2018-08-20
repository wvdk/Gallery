//
//  ArtPieceCollectionGridViewCell+FocusingViewDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/2/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension ArtPieceCollectionGridViewCell: FocusingViewDelegate {
    
    // MARK: - FocusingViewDelegate implementation
    
    func focusingViewDidBecomeFocused(_ focusingView: FocusingView) {
        showArtPiece()
    }
    
    func focusingViewDidResignedFocus(_ focusingView: FocusingView) {
        hideArtPiece()
    }
}
