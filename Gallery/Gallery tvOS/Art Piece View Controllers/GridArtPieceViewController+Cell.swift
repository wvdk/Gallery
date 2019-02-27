//
//  ArtPieceCollectionGridViewController+CollectionViewCellDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension GridArtPieceViewController: ArtPieceCollectionViewCellDelegate {
    
    // MARK: - CollectionViewCellDelegate implementation
    
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtPiece: PieceMetadata) {
        delegate?.artPieceViewControllerDelegate(self, didSelectOpenArtPiece: didSelectOpenArtPiece)
    }
}
