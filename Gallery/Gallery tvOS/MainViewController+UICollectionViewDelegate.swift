//
//  MainViewController+UICollectionViewDelegate.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        if collectionView.indexPathsForSelectedItems != nil, let focusedCell = context.nextFocusedView as? ArtPieceCollectionViewCell {
            focusedCell.alpha = 1
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let focusedCell = context.previouslyFocusedView as? ArtPieceCollectionViewCell {
            coordinator.addCoordinatedAnimations({
                focusedCell.alpha = 0.5
            })
        }
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceCollectionViewCell.identifier, for: indexPath) as! ArtPieceCollectionViewCell
        
        cell.alpha = 0.5
        
//        cell.piece = MasterList.shared.activePieces[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidthConstrain, height: collectionViewHeightConstrain - 100)
    }
}
