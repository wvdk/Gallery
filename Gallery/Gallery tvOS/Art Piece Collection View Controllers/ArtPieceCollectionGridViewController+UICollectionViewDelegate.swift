//
//  ArtPieceCollectionGridViewController+UICollectionViewDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension ArtPieceCollectionGridViewController: UICollectionViewDelegate {
    
    // MARK: - UICollectionViewDelegate implementation
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MasterList.shared.activePieces.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        // Animates selection of focused cells.
        if let nextFocusedView = context.nextFocusedView as? FocusingView {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                nextFocusedView.transformScale(to: 1.1)
            }, completion: nil)
        }
        
        // Animates deselection of focused cells.
        if let previouslyFocusedView = context.previouslyFocusedView as? FocusingView {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                previouslyFocusedView.transformScale(to: 1)
            }, completion: nil)
        }
    }
}

extension ArtPieceCollectionGridViewController: UICollectionViewDataSource {
    
    // MARK: - UICollectionViewDataSource implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceCollectionViewCell.identifier, for: indexPath) as! ArtPieceCollectionViewCell
        
        cell.delegate = self
        cell.contentViewEdgeInset = 30
        cell.artPiece = MasterList.shared.activePieces[indexPath.item]
        
        return cell
    }
}

extension ArtPieceCollectionGridViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegateFlowLayout implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width * 435 / 1920
        let height = view.frame.size.height * 263 / 1119
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let left = view.frame.size.width * 90 / 1920
        let right = view.frame.size.width * 51 / 1920
        return UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
    }
}
