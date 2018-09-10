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
            focusingView.thumbnail = piece.thumbnail

            // Sets view of art piece to initialized art piece view.
//            piece.view = piece.viewType.init(frame: bounds, artPieceMetadata: piece)
        }
    }
    
    /// Cell's content (art piece view) edge inset.
    var contentViewEdgeInset: CGFloat = 0 {
        didSet {
            focusingView.constraint(edgesTo: self, constant: contentViewEdgeInset)
        }
    }
    
    private var artView: ArtView?
    private var focusingView = FocusingView()
    
    // MARK: - UICollectionViewCell properties
    
    override var canBecomeFocused: Bool {
        // Cell cannot be focus to allow its subviews to become focused.
        return false
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        focusingView.delegate = self
        addSubview(focusingView)

        focusingView.addSingleTapGestureRecognizer { [weak self] recognizer in
            recognizer.allowedPressTypes = [
                NSNumber(value: UIPressType.playPause.rawValue),
                NSNumber(value: UIPressType.select.rawValue)
            ]
            
            if let strongSelf = self, let artPiece = self?.artPiece {
                strongSelf.hideArtPiece()
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
        focusingView.show(subview: view)
    }
    
    /// Removes specific art piece view from parents view.
    func hideArtPiece() {
        guard let view = artView else { return }
        focusingView.hide(subview: view)
        artView = nil
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
