//
//  ArtPieceViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

protocol ArtPieceViewControllerDelegate: class {
    
    /// Tells the delegate that an art piece was selected to be opened.
    ///
    /// - Parameters:
    ///     - viewController: A view controller object informing the delegate about the selected art piece.
    ///     - didSelectOpenArtPiece: A selected to open art piece metadata.
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtPiece: ArtMetadata)
    
    /// Tells the delegate that an art piece description was selected to be opened.
    ///
    /// - Parameters:
    ///     - viewController: A view controller object informing the delegate about the selected art piece description.
    ///     - didSelectOpenArtDescription: A selected to open art piece  description metadata.
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtDescription: ArtMetadata)
}
