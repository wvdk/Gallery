//
//  GridArtPieceViewController+UICollectionViewDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension GridArtPieceViewController: UICollectionViewDelegate {
    
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
        // Animates selection of focused cells.
        // Doing it here because collection views use the same focused view but different scale coefficient.
        if let nextFocusedView = context.nextFocusedView as? FocusingView {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                nextFocusedView.transformScale(to: 1.3)
            }, completion: nil)
        }
    }
}

extension GridArtPieceViewController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceViewCell.identifier, for: indexPath) as! ArtPieceViewCell
        
        cell.delegate = self
        cell.contentViewEdgeInset = CGSize(width: view.frame.size.width * 30 / 1920,
                                           height: view.frame.size.height * 17 / 1119)
        cell.showsPreviewOnFocus = false
        cell.artPiece = MasterList.shared.activePieces[indexPath.item]
        
        return cell
    }
}

extension GridArtPieceViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width * 440 / 1920
        let height = view.frame.size.height * 256 / 1119
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left = view.frame.size.width * 58 / 1920
        let right = view.frame.size.width * 58 / 1920
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
}
