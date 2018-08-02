//
//  NotFeaturedArtPieceViewController+UICollectionViewDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

extension NotFeaturedArtPieceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MasterList.shared.activePieces.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//
//        guard let nextFocusedIndexPath = context.nextFocusedIndexPath else { return }
//
//        if let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath, nextFocusedIndexPath == previouslyFocusedIndexPath {
//            return
//        }
//
//        collectionView.scrollToItem(at: nextFocusedIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
//
//        if let nextFocusedItem = context.nextFocusedItem,
//            let focusedCell = collectionView.cellForItem(at: nextFocusedIndexPath),
//            focusedCell.contains(nextFocusedItem) {
//
//            coordinator.addCoordinatedFocusingAnimations({ (animationContext) in
//                collectionView.deselectAllItems()
//                focusedCell.isSelected = true
//            }, completion: nil)
//        }
//
//        if let previouslyFocusedItem = context.previouslyFocusedItem,
//            let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath,
//            let unfocusedCell = collectionView.cellForItem(at: previouslyFocusedIndexPath),
//            unfocusedCell.contains(previouslyFocusedItem) {
//
//            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
//                unfocusedCell.isSelected = false
//            }, completion: nil)
//        }
//    }
}

extension NotFeaturedArtPieceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotFeaturedArtPieceCollectionViewCell.identifier, for: indexPath) as! NotFeaturedArtPieceCollectionViewCell
        
        cell.artPiece = MasterList.shared.activePieces[indexPath.item]
        
        return cell
    }
}

extension NotFeaturedArtPieceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 435, height: 263)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 90, bottom: 0, right: 51)
    }
}
