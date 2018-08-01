//
//  ArtPieceCollectionViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import GalleryCore_tvOS

class ArtPieceCollectionViewCell: UICollectionViewCell {
    
    lazy var artPieceSize = CGSize(width: 880 / 1458 * self.frame.size.width, height: 497 / 829 * self.frame.size.height)
    lazy var artPieceTopEdgeInset = 147 / 829 * self.frame.size.height
    lazy var artPieceTrailingEdgeInset = 51 / 1458 * self.frame.size.width
    lazy var artPieceLeadingEdgeInset = 60 / 829 * self.frame.size.height
    lazy var purchaseButtonHeight = 50 / 829 * self.frame.size.height
    
    // MARK: - Properties
    
    static let identifier = "ArtPieceCollectionViewCellIdentifier"
    
    var id: Int? = 999 {
        didSet {
            if let id = self.id {
                titleLabel.text = "\(id)"
            }
        }
    }
    
    var artPiece: ArtMetadata? = nil {
        didSet {
            guard let artPiece = artPiece else { return }
            authorNameLabel.text = "\(artPiece.author)"
            dateLabel.text = "\(artPiece.prettyPublishedDate)"
            
            purchaseButton.setTitle("$99.99", for: .normal)
            //        titleLabel.text = "Windows"
            descriptionLabel.text = "Lorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam"
            
            let artView = artPiece.viewType.init(frame: artPieceView.bounds, artPieceMetadata: artPiece)
            artPieceView.addSubview(artPieceView: artView)
        }
    }
    
    private var descriptionExpandingLabelFocusGuide = UIFocusGuide()
    private var artPieceViewFocusGuide = UIFocusGuide()
    
    private let artPieceView = FocusingView()
    
    private let purchaseButton = UIButton(type: .system)
    
    private let authorNameLabel = HeadlineLabel(isFontBold: true)
    private let titleLabel = BodyLabel()
    private let dateLabel = BodyLabel()
    private let descriptionLabel = BodyLabel()
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
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        
        purchaseButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
        descriptionExpandingLabel.text = "...More"
        
        let descriptionStackView = setupDescriptionStackView()
        
        self.addSubview(descriptionStackView)
        self.addSubview(descriptionExpandingLabel)
        self.addSubview(artPieceView)
        self.addSubview(purchaseButton)
        
        self.addLayoutGuide(descriptionExpandingLabelFocusGuide)
        self.addLayoutGuide(artPieceViewFocusGuide)
        
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionExpandingLabel.translatesAutoresizingMaskIntoConstraints = false
        artPieceView.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionStackView.topAnchor.constraint(equalTo: artPieceView.topAnchor, constant: -31).isActive = true
        descriptionStackView.bottomAnchor.constraint(lessThanOrEqualTo: purchaseButton.topAnchor, constant: -110).isActive = true
        descriptionStackView.trailingAnchor.constraint(equalTo: artPieceView.leadingAnchor, constant: -artPieceLeadingEdgeInset).isActive = true
        descriptionStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 31).isActive = true
        
        descriptionExpandingLabel.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor).isActive = true
        descriptionExpandingLabel.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor).isActive = true
        
        artPieceView.topAnchor.constraint(equalTo: self.topAnchor, constant: artPieceTopEdgeInset).isActive = true
        artPieceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -artPieceTrailingEdgeInset).isActive = true
        artPieceView.heightAnchor.constraint(equalToConstant: artPieceSize.height).isActive = true
        artPieceView.widthAnchor.constraint(equalToConstant: artPieceSize.width).isActive = true
        
        purchaseButton.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor).isActive = true
        purchaseButton.bottomAnchor.constraint(equalTo: artPieceView.bottomAnchor, constant: 9).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: purchaseButtonHeight).isActive = true
        
        descriptionExpandingLabelFocusGuide.topAnchor.constraint(equalTo: descriptionExpandingLabel.topAnchor).isActive = true
        descriptionExpandingLabelFocusGuide.bottomAnchor.constraint(equalTo: descriptionExpandingLabel.bottomAnchor).isActive = true
        descriptionExpandingLabelFocusGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        descriptionExpandingLabelFocusGuide.trailingAnchor.constraint(equalTo: self.descriptionExpandingLabel.leadingAnchor).isActive = true
        
        artPieceViewFocusGuide.topAnchor.constraint(equalTo: artPieceView.topAnchor).isActive = true
        artPieceViewFocusGuide.trailingAnchor.constraint(equalTo: artPieceView.leadingAnchor).isActive = true
        artPieceViewFocusGuide.bottomAnchor.constraint(equalTo: purchaseButton.bottomAnchor).isActive = true
        artPieceViewFocusGuide.leadingAnchor.constraint(equalTo: purchaseButton.trailingAnchor).isActive = true
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
        
        // Hides `descriptionExpandingLabel` if `descriptionLabel` text is not truncated.
        descriptionExpandingLabel.isHidden = !descriptionLabel.isTruncated
    }
}
