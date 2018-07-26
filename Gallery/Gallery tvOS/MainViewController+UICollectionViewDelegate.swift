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
    
//    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
//        guard let indexPaths = collectionView.indexPathsForSelectedItems else {
//            return true
//        }
//        return indexPaths.isEmpty
//    }
//
//    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        guard let indexPath = collectionView.indexPathsForSelectedItems?.first else {
//            return true
//        }
//        collectionView.deselectItem(at: indexPath, animated: true)
//        return false
//    }
}

extension MainViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtPieceCollectionViewCell.identifier, for: indexPath) as! ArtPieceCollectionViewCell
        
//        cell.piece = MasterList.shared.activePieces[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewCellWidthConstrain, height: collectionViewHeightConstrain - 100)
    }
}
