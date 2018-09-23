//
//  FeaturedArtPieceCollectionViewController+CollectionViewCellDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension FeaturedArtPieceCollectionViewController: ArtPieceCollectionViewCellDelegate {
    
    // MARK: - CollectionViewCellDelegate implementation
    
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtPiece: PieceMetadata) {
        delegate?.artPieceCollectionControllerDelegate(self, didSelectOpenArtPiece: didSelectOpenArtPiece)
    }
}
