//
//  ArtPieceBaseViewController+ArtPieceViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension ArtPieceBaseViewController: ArtPieceViewControllerDelegate {
    
    // MARK: - ArtPieceViewControllerDelegate implementation
    
    func artPieceViewControllerDelegate(_ viewController: UIViewController, didSelectOpenArtPiece: PieceMetadata) {
        
        // Presents single art piece full screen mode.
        if self.artPieceDisplayController == nil {
            artPieceDisplayController = ArtPieceDisplayViewController(artMetadata: didSelectOpenArtPiece)
        }
        
        guard let artPieceDetailController = self.artPieceDisplayController else { return }
        artPieceDetailController.delegate = self
        present(artPieceDetailController, animated: true, completion: nil)
    }
}
