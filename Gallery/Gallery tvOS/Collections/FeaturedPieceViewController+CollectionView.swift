//
//  FeaturedPieceViewController+UICollectionViewDelegate.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension FeaturedPieceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        if let nextFocusedView = context.nextFocusedView as? ParralaxView {
            coordinator.addCoordinatedUnfocusingAnimations({ (animationContext) in
                nextFocusedView.transformScale(to: CGSize(width: 1.3, height: 1.3))
                nextFocusedView.transformTranslation(by: CGPoint(x: 0, y: -nextFocusedView.bounds.size.height * 0.15))
            }, completion: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource implementation
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PieceViewCell.identifier, for: indexPath) as! PieceViewCell

        cell.delegate = self
        
        let horizontalInset = view.frame.size.width * 0.08
        let topInset = view.frame.size.height * 0.29
        let bottomInset = view.frame.size.height * 0.14
        cell.contentViewEdgeInset = UIEdgeInsets(top: topInset, left: horizontalInset, bottom: bottomInset, right: horizontalInset)
        
        cell.pieceMetadata = MasterList.shared.activePieces[indexPath.item]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout implementation
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.63, height: view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let constant = view.frame.size.width * 0.19
        return UIEdgeInsets(top: 0, left: constant, bottom: 0, right: constant)
    }
}
