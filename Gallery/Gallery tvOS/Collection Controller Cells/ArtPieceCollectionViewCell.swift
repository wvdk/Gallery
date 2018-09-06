//
//  ArtPieceCollectionViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UICollectionViewCell` which contains:
/// - Art piece preview view.
/// - Description info:
///     - Author name
///     - Title
///     - Date
///     - Description
/// - Purchase button.
class ArtPieceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FeaturedArtPieceCollectionViewCellIdentifier"
    
    /// The object that acts as the delegate of the `CollectionViewCellDelegate`.
    weak var delegate: ArtPieceCollectionViewCellDelegate?
    
    /// Metadata of art piece presented by cell.
    var artPiece: ArtMetadata? = nil {
        didSet {
            guard let piece = artPiece else { return }
            artPieceView.thumbnail = piece.thumbnail

            // Sets view of art piece to initialized art piece view.
//            piece.view = piece.viewType.init(frame: bounds, artPieceMetadata: piece)
        }
    }
    
    /// Cell's content (art piece view) edge inset.
    var contentViewEdgeInset: CGFloat = 0 {
        didSet {
            artPieceView.constraint(edgesTo: self, constant: contentViewEdgeInset)
        }
    }
    
    var isArtViewFocused = false
    
    private var artView: ArtView?
    private let artPieceView = FocusingView()
    
    // MARK: - UICollectionViewCell properties
    
    override var canBecomeFocused: Bool {
        // Cell cannot be focus to allow its subviews to become focused.
        return false
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        artPieceView.delegate = self
        addSubview(artPieceView)

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
    
    // MARK: - Appearance
    
    /// Creates a new instance view of specific art piece and adds it to the `artPieceView`.
    func showArtPiece() {
        if let piece = artPiece, artView == nil {
            artView = piece.viewType.init(frame: bounds, artPieceMetadata: piece)
        }
        
        guard let view = artView else { return }
        artPieceView.show(subview: view)
    }
    
    /// Removes specific art piece view from parents view.
    func hideArtPiece() {
        guard let view = artView else { return }
        artPieceView.hide(subview: view)
        artView = nil
    }
    
    /// Transforms art piece scale to specified value.
    func transformScale(to value: CGFloat) {
        artPieceView.transform = CGAffineTransform(scaleX: value, y: value)
    }
}

/// The object that acts as the delegate of the art piece collection view cells.
///
/// The delegate must adopt the ArtPieceCollectionViewCellDelegate protocol.
///
/// The delegate object is responsible for managing selection behavior for cell subviews.
protocol ArtPieceCollectionViewCellDelegate: class {
    
    /// Tells the delegate that an art piece was selected to be opened.
    ///
    /// - Parameters:
    ///     - cell: An item informing the delegate about the selected art piece.
    ///     - didSelectOpenArtPiece: A selected to open art piece metadata.
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenArtPiece: ArtMetadata)
}
