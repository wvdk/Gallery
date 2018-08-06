//
//  ArtPieceViewControllerDelegate.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

protocol ArtPieceViewControllerDelegate: class {
    
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtMetadata: ArtMetadata)
    
    func artPieceControllerDelegate(_ viewController: UIViewController, didSelectOpenArtDescription: ArtMetadata)
}
