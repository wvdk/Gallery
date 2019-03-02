//
//  PieceViewController+UICollectionViewDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension PieceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        if let nextFocusedView = context.nextFocusedView as? ParralaxView {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                nextFocusedView.transformScale(to: CGSize(width: 1.3, height: 1.3))
            }, completion: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PieceViewCell.identifier, for: indexPath) as! PieceViewCell
        
        cell.delegate = self
        
        let horizontalInset = view.frame.size.width * 0.016
        let verticalInset = view.frame.size.height * 0.015
        cell.contentViewEdgeInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        cell.showPreviewOnFocus = false
        cell.pieceMetadata = MasterList.shared.activePieces[indexPath.item]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.23, height: view.frame.size.height * 0.23)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let constant = view.frame.size.width * 0.03
        return UIEdgeInsets(top: 0, left: constant, bottom: 0, right: constant)
    }
}
