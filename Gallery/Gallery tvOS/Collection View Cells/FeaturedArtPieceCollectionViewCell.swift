//
//  FeaturedArtPieceCollectionViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

class FeaturedArtPieceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "FeaturedArtPieceCollectionViewCellIdentifier"
    
    weak var delegate: CollectionViewCellDelegate?
    
    var artPiece: ArtMetadata? = nil {
        didSet {
            guard let piece = artPiece else { return }
            artPieceView.thumbnail = piece.thumbnail
            authorNameLabel.text = "\(piece.author)"
            dateLabel.text = "\(piece.prettyPublishedDate)"
            titleLabel.text = "\(piece.id)"

            self.artPiece?.view = piece.viewType.init(frame: self.bounds, artPieceMetadata: piece)
            
            if let price = piece.price {
                let priceTitle = "$ \(price)"
                purchaseButton.setTitle(priceTitle, for: .normal)
            } else {
                removePurchaseButton()
            }
            
            if let description = piece.description {
                descriptionLabel.text = description
            } else {
                removeDescriptionExpandingLabel()
                removeDescriptionLabel()
            }
        }
    }
    
    private var descriptionExpandingLabelFocusGuide = UIFocusGuide()
    private var artPieceViewFocusGuide = UIFocusGuide()
    
    private var artView: ArtView?
    private let artPieceView = FocusingView()
    
    private let purchaseButton = UIButton(type: .system)
    
    private let authorNameLabel = HeadlineLabel(isFontBold: true)
    private let titleLabel = BodyLabel(color: .gray)
    private let dateLabel = BodyLabel(color: .gray)
    private let descriptionLabel = BodyLabel(color: .gray)
    private let descriptionExpandingLabel = FocusingLabel()
    
    // MARK: - UICollectionViewCell properties
    
    override var canBecomeFocused: Bool {
        return false
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [descriptionExpandingLabel]
    }
    
    override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            
            if isSelected {
                self.alpha = 1
            } else {
                self.alpha = 0.5
            }
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
        descriptionExpandingLabel.text = "...More"
        
        artPieceView.delegate = self
        
        let descriptionHeaderStackView = setupDescriptionStackView()
        
        self.addSubview(descriptionHeaderStackView)
        self.addSubview(descriptionExpandingLabel)
        self.addSubview(artPieceView)
        self.addSubview(purchaseButton)
        
        self.addLayoutGuide(descriptionExpandingLabelFocusGuide)
        self.addLayoutGuide(artPieceViewFocusGuide)
        
        descriptionHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionExpandingLabel.translatesAutoresizingMaskIntoConstraints = false
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionHeaderStackView.topAnchor.constraint(equalTo: artPieceView.topAnchor, constant: -30).isActive = true
        descriptionHeaderStackView.bottomAnchor.constraint(lessThanOrEqualTo: artPieceView.bottomAnchor, constant: -150).isActive = true
        descriptionHeaderStackView.trailingAnchor.constraint(equalTo: artPieceView.leadingAnchor, constant: -60).isActive = true
        descriptionHeaderStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true

        descriptionExpandingLabel.topAnchor.constraint(equalTo: descriptionHeaderStackView.bottomAnchor).isActive = true
        descriptionExpandingLabel.trailingAnchor.constraint(equalTo: descriptionHeaderStackView.trailingAnchor).isActive = true
        
        artPieceView.topAnchor.constraint(equalTo: self.topAnchor, constant: 150).isActive = true
        artPieceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        artPieceView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        artPieceView.widthAnchor.constraint(equalToConstant: 880).isActive = true
        
        purchaseButton.trailingAnchor.constraint(equalTo: descriptionHeaderStackView.trailingAnchor).isActive = true
        purchaseButton.bottomAnchor.constraint(equalTo: artPieceView.bottomAnchor, constant: 9).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descriptionExpandingLabelFocusGuide.topAnchor.constraint(equalTo: descriptionExpandingLabel.topAnchor).isActive = true
        descriptionExpandingLabelFocusGuide.bottomAnchor.constraint(equalTo: descriptionExpandingLabel.bottomAnchor).isActive = true
        descriptionExpandingLabelFocusGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        descriptionExpandingLabelFocusGuide.trailingAnchor.constraint(equalTo: self.descriptionExpandingLabel.leadingAnchor).isActive = true
        
        artPieceViewFocusGuide.topAnchor.constraint(equalTo: artPieceView.topAnchor).isActive = true
        artPieceViewFocusGuide.trailingAnchor.constraint(equalTo: artPieceView.leadingAnchor).isActive = true
        artPieceViewFocusGuide.bottomAnchor.constraint(equalTo: purchaseButton.bottomAnchor).isActive = true
        artPieceViewFocusGuide.leadingAnchor.constraint(equalTo: purchaseButton.trailingAnchor).isActive = true
        
        artPieceView.addSingleTapGestureRecognizer { [weak self] recognizer in
            recognizer.allowedPressTypes = [
                NSNumber(value: UIPressType.playPause.rawValue),
                NSNumber(value: UIPressType.select.rawValue)
            ]
            
            if let strongSelf = self, let artPiece = self?.artPiece {
                strongSelf.delegate?.collectionViewCell(strongSelf, didSelectOpenArtPiece: artPiece)
            }
        }
        
        descriptionExpandingLabel.addSingleTapGestureRecognizer { [weak self] recognizer in
            recognizer.allowedPressTypes = [
                NSNumber(value: UIPressType.select.rawValue)
            ]
            
            if let strongSelf = self, let artPiece = self?.artPiece {
                strongSelf.delegate?.collectionViewCell(strongSelf, didSelectOpenArtDescription: artPiece)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Stackview setup
    
    private func setupDescriptionStackView() -> UIStackView {
        let labelViews = [authorNameLabel, titleLabel, dateLabel, descriptionLabel]
        let stackView = UIStackView(arrangedSubviews: labelViews)

        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        stackView.alignment = .trailing
        
        return stackView
    }
    
    // MARK: - Layout update
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.alpha = 0.5
    }
        
    // MARK: - UIFocusEnvironment update
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        
        guard let nextFocusedView = context.nextFocusedView else { return }
        
        switch nextFocusedView {
        case artPieceView:
            artPieceViewFocusGuide.preferredFocusEnvironments = [descriptionExpandingLabel]
        default:
            artPieceViewFocusGuide.preferredFocusEnvironments = []
        }
    }
    
    // MARK: - Appearance
    
    func showArtPiece() {
        if let piece = artPiece, artView == nil {
            artView = piece.viewType.init(frame: self.bounds, artPieceMetadata: piece)
        }
        
        guard let view = artView else { return }
        artPieceView.addSubview(artPieceView: view)
    }
    
    func hideArtPiece() {
        guard let view = artView else { return }
        view.removeFromSuperview()
        artView = nil
    }
    
    private func removeDescriptionLabel() {
        descriptionLabel.removeFromSuperview()
        removeLayoutGuide(descriptionExpandingLabelFocusGuide)
    }
    
    private func removeDescriptionExpandingLabel() {
        descriptionExpandingLabel.removeFromSuperview()
    }
    
    private func removePurchaseButton() {
        purchaseButton.removeFromSuperview()
    }
    
    func updateCellAppearance() {
        // Removes `descriptionExpandingLabel` if `descriptionLabel` text is not truncated.
        if !descriptionLabel.isTruncated {
            removeDescriptionExpandingLabel()
        }
    }
}
