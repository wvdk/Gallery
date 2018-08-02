//
//  NotFeaturedArtPieceCollectionViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

class NotFeaturedArtPieceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "NotFeaturedArtPieceCollectionViewCellIdentifier"
    
    private let artPieceView = FocusingView()
    private let titleLabel = BodyLabel()
    
    var artPiece: ArtMetadata? = nil {
        didSet {
            guard let artPiece = artPiece else { return }
            titleLabel.text = "\(artPiece.id)"
            
            let artView = artPiece.viewType.init(frame: artPieceView.bounds, artPieceMetadata: artPiece)
            artPieceView.addSubview(artPieceView: artView)
        }
    }
    
    // MARK: - UICollectionViewCell properties
    
    override var canBecomeFocused: Bool {
        return false
    }

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(artPieceView)
        self.addSubview(titleLabel)
        
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artPieceView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
        artPieceView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36).isActive = true
        artPieceView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 47).isActive = true
        artPieceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -47).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: artPieceView.bottomAnchor, constant: 0).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: artPieceView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
