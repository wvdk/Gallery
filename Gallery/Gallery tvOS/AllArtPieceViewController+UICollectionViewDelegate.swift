//
//  AllArtPieceViewController+UICollectionViewDelegate.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

extension AllArtPieceViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        guard let nextFocusedIndexPath = context.nextFocusedIndexPath else { return }
        
        if context.previouslyFocusedIndexPath == nil { return }
        
        if let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath, nextFocusedIndexPath == previouslyFocusedIndexPath {
            return
        }
        
        collectionView.scrollToItem(at: nextFocusedIndexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        
        if let nextFocusedItem = context.nextFocusedItem,
            let focusedCell = collectionView.cellForItem(at: nextFocusedIndexPath),
            focusedCell.contains(nextFocusedItem) {
            
            coordinator.addCoordinatedFocusingAnimations({ (animationContext) in
                collectionView.deselectAllItems()
                focusedCell.isSelected = true
            }, completion: nil)
        }
        
        if let previouslyFocusedItem = context.previouslyFocusedItem,
            let previouslyFocusedIndexPath = context.previouslyFocusedIndexPath,
            let unfocusedCell = collectionView.cellForItem(at: previouslyFocusedIndexPath),
            unfocusedCell.contains(previouslyFocusedItem) {
            
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                unfocusedCell.isSelected = false
            }, completion: nil)
        }
    }
}

extension AllArtPieceViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceCollectionViewCell.identifier, for: indexPath) as! ArtPieceCollectionViewCell
        
        cell.id = indexPath.item
        
//        cell.piece = MasterList.shared.activePieces[indexPath.row]
        
        return cell
    }
}

extension AllArtPieceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidthConstrain, height: collectionViewHeightConstrain - 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: collectionViewLeftEdgeInset, bottom: 0, right: 0)
    }
}
