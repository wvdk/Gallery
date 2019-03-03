//
//  PieceViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// The object that acts as the delegate of the art piece collection view cells.
///
/// The delegate must adopt the PieceCollectionViewCellDelegate protocol.
///
/// The delegate object is responsible for managing selection behavior for cell subviews.
protocol PieceCollectionViewCellDelegate: class {
    
    /// Tells the delegate that an art piece was selected to be opened.
    ///
    /// - Parameters:
    ///     - cell: An item informing the delegate about the selected art piece.
    ///     - didSelectOpenPiece: A selected to open art piece metadata.
    func collectionViewCell(_ cell: UICollectionViewCell, didSelectOpenPiece: PieceMetadata)
}

/// A subclass of `UICollectionViewCell` which contains:
/// - Art piece preview view.
/// - Description info:
///     - Author name
///     - Title
///     - Date
///     - Description
/// - Purchase button.
class PieceViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FeaturedPieceCellIdentifier"
    
    /// The object that acts as the delegate of the `CollectionViewCellDelegate`.
    weak var delegate: PieceCollectionViewCellDelegate?
    
    var showPreviewOnFocus = true
    
    /// Metadata of art piece presented by cell.
    var pieceMetadata: PieceMetadata? = nil {
        didSet {
            guard let piece = pieceMetadata else {
                return
            }
            
            focusingView.thumbnail = piece.thumbnail
            
            if showPreviewOnFocus {
                focusingView.artViewType = piece.viewType
            }
        }
    }
    
    /// Cell's content (art piece view) edge inset.
    var contentViewEdgeInset: UIEdgeInsets = .zero {
        didSet {
            focusingView.constraint(edgesTo: self, edgeInset: self.contentViewEdgeInset)
        }
    }
    
    private let focusingView = ParralaxView()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(focusingView)

        focusingView.addSingleTapGestureRecognizer { [weak self] recognizer in
            recognizer.allowedPressTypes = [
                NSNumber(value: UIPress.PressType.playPause.rawValue),
                NSNumber(value: UIPress.PressType.select.rawValue)
            ]
            
            if let self = self, let metadata = self.pieceMetadata {
                self.delegate?.collectionViewCell(self, didSelectOpenPiece: metadata)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
