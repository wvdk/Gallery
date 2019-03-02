//
//  MainViewController+PieceViewController.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension MainViewController: PieceViewControllerDelegate {
    
    // MARK: - PieceViewControllerDelegate implementation
    
    func pieceViewControllerDelegate(_ viewController: UIViewController, didSelectOpenPiece: PieceMetadata) {
        
        // Presents single art piece full screen mode.
        if self.pieceDisplayController == nil {
            pieceDisplayController = PieceDisplayViewController(artMetadata: didSelectOpenPiece)
        }
        
        guard let pieceDisplayController = self.pieceDisplayController else { return }
        pieceDisplayController.delegate = self
        present(pieceDisplayController, animated: true, completion: nil)
    }
}
