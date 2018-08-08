//
//  ArtPieceCollectionGridViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UICollectionViewCell` which contains:
/// - Art piece preview view.
/// - Art piece title.
class ArtPieceCollectionGridViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "ArtPieceCollectionGridViewCellIdentifier"
    
    /// The object that acts as the delegate of the `CollectionViewCellDelegate`.
    weak var delegate: CollectionViewCellDelegate?
    
    /// Metadata of art piece presented by cell.
    var artPiece: ArtMetadata? = nil {
        didSet {
            guard var piece = artPiece else { return }
            artPieceView.thumbnail = piece.thumbnail
            titleLabel.text = "\(piece.id)"
            
            piece.view = piece.viewType.init(frame: bounds, artPieceMetadata: piece)
        }
    }
    
    private var artView: ArtView?
    
    private let artPieceView = FocusingView()
    
    private let titleLabel = BodyLabel(color: .darkGray)
    
    // MARK: - UICollectionViewCell properties
    
    override var canBecomeFocused: Bool {
        // Cell cannot be focus to allow its subviews to become focused.
        return false
    }

    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Initially hide title label.
        titleLabel.alpha = 0
        
        artPieceView.delegate = self
        
        addSubview(artPieceView)
        addSubview(titleLabel)
        
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        artPieceView.topAnchor.constraint(equalTo: topAnchor, constant: 36).isActive = true
        artPieceView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -36).isActive = true
        artPieceView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 47).isActive = true
        artPieceView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -47).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: artPieceView.bottomAnchor, constant: 15).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: artPieceView.centerXAnchor).isActive = true
        
        artPieceView.addSingleTapGestureRecognizer { [weak self] recognizer in
            recognizer.allowedPressTypes = [
                NSNumber(value: UIPressType.playPause.rawValue),
                NSNumber(value: UIPressType.select.rawValue)
            ]
            
            if let strongSelf = self, let artPiece = self?.artPiece {
                strongSelf.delegate?.collectionViewCell(strongSelf, didSelectOpenArtPiece: artPiece)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIFocusEnvironment update
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        // Animate title label appearance.
        // Title label is shown when cell is focused.
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
    
    // MARK: - Art view appearance
    
    /// Creates a new instance view of specific art piece and adds it to the `artPieceView`.
    func showArtPiece() {
        if let piece = artPiece, artView == nil {
            artView = piece.viewType.init(frame: bounds, artPieceMetadata: piece)
        }
        
        guard let view = artView else { return }
        artPieceView.addSubview(artPieceView: view)
    }
    
    /// Removes specific art piece view from parents view.
    func hideArtPiece() {
        guard let view = artView else { return }
        view.removeFromSuperview()
        artView = nil
    }
}
