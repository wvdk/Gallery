//
//  AllArtPiecesViewController+ArtPieceViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

extension AllArtPiecesViewController: ArtPieceViewControllerDelegate {
    
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtView: ArtView) {
        print("did select item")
//        let vc = UIViewController()
//        vc.view.addSubview(didSelectOpenArtView)
//        present(vc, animated: true, completion: nil)
    }
}
