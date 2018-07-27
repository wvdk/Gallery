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

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let nextFocusedIndexPath = context.nextFocusedIndexPath, let focusedCell = collectionView.cellForItem(at: nextFocusedIndexPath) {
            coordinator.addCoordinatedFocusingAnimations({ (animationContext) in
                focusedCell.alpha = 1
            }, completion: nil)
        }
        
        if let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath, let unfocusedCell = collectionView.cellForItem(at: previouslyFocusedIndexPath) {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                unfocusedCell.alpha = 0.5
            }, completion: nil)
        }
        
        if context.nextFocusedIndexPath != nil && !collectionView.isScrollEnabled {
            collectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceCollectionViewCell.identifier, for: indexPath) as! ArtPieceCollectionViewCell
        
        cell.myNumber = indexPath.item
        
//        cell.piece = MasterList.shared.activePieces[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidthConstrain, height: collectionViewHeightConstrain - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionViewLeftEdgeInset, bottom: 0, right: 0)
    }
}
