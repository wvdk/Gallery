//
//  FeaturedArtPieceCollectionViewController+UICollectionViewDelegate.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension FeaturedArtPieceCollectionViewController: UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate implementation
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MasterList.shared.activePieces.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // Scroll manually to constrain cells in the center of the screen.
        if let nextFocusedIndexPath = context.nextFocusedIndexPath {
            collectionView.scrollToItem(at: nextFocusedIndexPath,
                                        at: UICollectionView.ScrollPosition.centeredHorizontally,
                                        animated: true)
        }
        
        // Animates selection of focused cells.
        // Doing it here because collection views use the same focused view but different scale coefficient.
        if let nextFocusedView = context.nextFocusedView as? FocusingView {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                nextFocusedView.transformScale(to: 1.25)
            }, completion: nil)
        }
    }
}

extension FeaturedArtPieceCollectionViewController: UICollectionViewDataSource {

    // MARK: - UICollectionViewDataSource implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceCollectionViewCell.identifier, for: indexPath) as! ArtPieceCollectionViewCell

        cell.delegate = self
        cell.contentViewEdgeInset = 90
        cell.artPiece = MasterList.shared.activePieces[indexPath.item]
        
        return cell
    }
}

extension FeaturedArtPieceCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width * 1074 / 1920
        let height = view.frame.size.height * 804 / 1119
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let constant = (view.frame.size.width - (view.frame.size.width * 1074 / 1920)) / 2
        return UIEdgeInsets(top: 0, left: constant, bottom: 0, right: constant)
    }
}
