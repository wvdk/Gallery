//
//  PieceViewController+Cell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension PieceViewController: PieceCollectionViewCellDelegate {
    
    // MARK: - CollectionViewCellDelegate implementation
    
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenPiece: PieceMetadata) {
        delegate?.pieceViewControllerDelegate(self, didSelectOpenPiece: didSelectOpenPiece)
    }
}
