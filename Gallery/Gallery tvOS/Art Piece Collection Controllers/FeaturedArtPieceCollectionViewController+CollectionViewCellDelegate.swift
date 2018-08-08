//
//  FeaturedArtPieceCollectionViewController+CollectionViewCellDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension FeaturedArtPieceCollectionViewController: CollectionViewCellDelegate {
    
    // MARK: - CollectionViewCellDelegate implementation
    
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtPiece: ArtMetadata) {
        delegate?.artPieceControllerDelegate(self, didSelectOpenArtPiece: didSelectOpenArtPiece)
    }
    
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtDescription: ArtMetadata) {
        delegate?.artPieceControllerDelegate(self, didSelectOpenArtDescription: didSelectOpenArtDescription)
    }
}
