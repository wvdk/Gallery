//
//  NotFeaturedArtPieceViewController+CollectionViewCellDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension NotFeaturedArtPieceViewController: CollectionViewCellDelegate {
    
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtView: ArtView) {
        self.delegate?.artPieceControllerDelegate(self, didSelectOpenArtView: didSelectOpenArtView)
    }
}
