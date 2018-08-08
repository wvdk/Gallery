//
//  AllArtPiecesViewController+ArtPieceViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension AllArtPiecesViewController: ArtPieceViewControllerDelegate {
    
    // MARK: - ArtPieceViewControllerDelegate implementation
    
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtPiece: ArtMetadata) {
        
        // Presents single art piece full screen mode.
        let artPieceDetailController = ArtPieceDisplayViewController(artMetadata: didSelectOpenArtPiece)
        present(artPieceDetailController, animated: true, completion: nil)
    }
    
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtDescription: ArtMetadata) {
        
        // Presents single art piece description full screen mode on top of existing context.
        let artPieceDetailController = ArtPieceDescriptionViewController(artMetadata: didSelectOpenArtDescription)
        artPieceDetailController.modalPresentationStyle = .overCurrentContext
        present(artPieceDetailController, animated: true, completion: nil)
    }
}
