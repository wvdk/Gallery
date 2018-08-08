//
//  CollectionViewCellDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// The object that acts as the delegate of the art piece collection view cells.
///
/// The delegate must adopt the CollectionViewCellDelegate protocol.
///
/// The delegate object is responsible for managing selection behavior for cell subviews.
protocol CollectionViewCellDelegate: class {
    
    /// Tells the delegate that an art piece was selected to be opened.
    ///
    /// - Parameters:
    ///     - cell: An item informing the delegate about the selected art piece.
    ///     - didSelectOpenArtPiece: A selected to open art piece metadata.
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtPiece: ArtMetadata)
    
    /// Tells the delegate that an art piece description was selected to be opened.
    ///
    /// - Parameters:
    ///     - cell: An item informing the delegate about the selected art piece description.
    ///     - didSelectOpenArtDescription: A selected to open art piece description metadata.
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtDescription: ArtMetadata)
}
