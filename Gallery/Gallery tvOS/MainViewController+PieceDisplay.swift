//
//  MainViewController+PieceDisplay.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/16/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension MainViewController: PieceDisplayViewControllerDelegate {

    // MARK: - PieceDisplayViewControllerDelegate implementation

    func pieceDisplayViewControllerDidSelectClose(_ viewController: PieceDisplayViewController) {
        guard let pieceDisplayController = self.pieceDisplayController else {
            return
        }

        pieceDisplayController.dismiss(animated: true, completion: nil)
        self.pieceDisplayController = nil
    }
}
