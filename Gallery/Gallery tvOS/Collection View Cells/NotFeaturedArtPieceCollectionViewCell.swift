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
    private let titleLabel = BodyLabel(color: .darkGray)
    
    var artView: ArtView?

    var artPiece: ArtMetadata? = nil {
        didSet {
            guard let artPiece = artPiece else { return }
            titleLabel.text = "\(artPiece.id)"
            
            artView = artPiece.viewType.init(frame: artPieceView.bounds, artPieceMetadata: artPiece)
            if let view = self.artView {
                artPieceView.addSubview(artPieceView: view)
            }
        }
    }
    
    // MARK: - UICollectionViewCell properties
    
    override var canBecomeFocused: Bool {
        return false
    }

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.alpha = 0
        
        artPieceView.delegate = self
        
        self.addSubview(artPieceView)
        self.addSubview(titleLabel)
        
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artPieceView.topAnchor.constraint(equalTo: self.topAnchor, constant: 36).isActive = true
        artPieceView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36).isActive = true
        artPieceView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 47).isActive = true
        artPieceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -47).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: artPieceView.bottomAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: artPieceView.centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIFocusEnvironment update
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        if artPieceView.isFocused {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.titleLabel.alpha = 1
                }, completion: nil)
        } else {
            coordinator.addCoordinatedFocusingAnimations({ [weak self] (animationContext) in
                self?.titleLabel.alpha = 0
                }, completion: nil)
        }
    }
}
