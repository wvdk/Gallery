//
//  ArtPieceContainerViewController+ArtPieceViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension ArtPieceContainerViewController: ArtPieceCollectionViewControllerDelegate {
    
    // MARK: - ArtPieceViewControllerDelegate implementation
    
    func artPieceCollectionControllerDelegate(_ viewController: UIViewController, didSelectOpenArtPiece: ArtMetadata) {
        
        // Presents single art piece full screen mode.
        if self.artPieceDetailController == nil {
            artPieceDetailController = ArtPieceDisplayViewController(artMetadata: didSelectOpenArtPiece)
        }
        
        guard let artPieceDetailController = self.artPieceDetailController else { return }
        artPieceDetailController.delegate = self
        present(artPieceDetailController, animated: true, completion: nil)
    }
}
