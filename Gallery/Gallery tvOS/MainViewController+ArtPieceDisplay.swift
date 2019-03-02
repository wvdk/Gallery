//
//  MainViewController+ArtPieceDisplay.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension MainViewController: ArtPieceDisplayViewControllerDelegate {

    // MARK: - ArtPieceDisplayViewControllerDelegate implementation

    func artPieceDisplayViewControllerDidSelectClose(_ viewController: ArtPieceDisplayViewController) {
        guard let artPieceDetailController = self.artPieceDisplayController else { return }

        artPieceDetailController.dismiss(animated: true, completion: nil)
        self.artPieceDisplayController = nil
    }
}
