//
//  ArtPieceContainerViewController+ArtPieceDisplayViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension ArtPieceContainerViewController: ArtPieceDisplayViewControllerDelegate {

    // MARK: - ArtPieceDisplayViewControllerDelegate implementation

    func artPieceDisplayViewControllerDidSelectClose(_ viewController: ArtPieceDisplayViewController) {
        guard let artPieceDetailController = self.artPieceDetailController else { return }

        artPieceDetailController.dismiss(animated: true, completion: nil)
        self.artPieceDetailController = nil
    }
}
