//
//  ArtPieceCollectionViewCell.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 7/25/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var artPieceSize = CGSize(width: 880 / 1458 * self.frame.size.width, height: 497 / 829 * self.frame.size.height)
    lazy var artPieceTopEdgeInset = 147 / 829 * self.frame.size.height
    lazy var artPieceTrailingEdgeInset = 51 / 1458 * self.frame.size.width
    lazy var artPieceLeadingEdgeInset = 60 / 829 * self.frame.size.height
    lazy var purchaseButtonHeight = 60 / 829 * self.frame.size.height
    
    static let identifier = "ArtPieceCollectionViewCellIdentifier"
    
    private var labelFocusGuide = UIFocusGuide()
    private var artPieceFocusGuide = UIFocusGuide()
    
    private let artPieceImageView = FocusedImageView()
    
    private let purchaseButton = UIButton(type: .system)
    
    private let authorNameLabel = HeadlineLabel()
    private let titleLabel = BodyLabel()
    private let dateLabel = BodyLabel()
    private let descriptionLabel = BodyLabel()
    private let descriptionExpandingLabel = FocusedLabel()

    private func setupDescriptionStackView() -> UIStackView {
        let labelViews = [authorNameLabel, titleLabel, dateLabel, descriptionLabel]
        let stackView = UIStackView(arrangedSubviews: labelViews)
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        stackView.alignment = .trailing
        
        return stackView
    }
    
    var myNumber: Int? {
        didSet {
            descriptionExpandingLabel.text = "ART \(myNumber!)"
        }
    }

    
    // MARK: - UICollectionViewCell focus setup
    
    override var canBecomeFocused: Bool {
        return false
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .red
        artPieceImageView.image = UIImage(named: "cell")
        purchaseButton.setTitle("$99", for: .normal)
        
        authorNameLabel.text = "Wesley Var der Klomp"
        titleLabel.text = "Stonegems"
        dateLabel.text = "2018 01 09"
        descriptionLabel.text = "Lorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam"
        
        let descriptionStackView = setupDescriptionStackView()
        
        self.addSubview(descriptionStackView)
//        self.addSubview(descriptionExpandingLabel)
        self.addSubview(purchaseButton)
        self.addSubview(artPieceImageView)
        
        self.addLayoutGuide(labelFocusGuide)
        self.addLayoutGuide(artPieceFocusGuide)
        
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        artPieceImageView.translatesAutoresizingMaskIntoConstraints = false
        purchaseButton.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionStackView.topAnchor.constraint(equalTo: artPieceImageView.topAnchor, constant: -31).isActive = true
        descriptionStackView.trailingAnchor.constraint(equalTo: artPieceImageView.leadingAnchor, constant: -artPieceLeadingEdgeInset).isActive = true
        
        labelFocusGuide.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        labelFocusGuide.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        labelFocusGuide.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        labelFocusGuide.trailingAnchor.constraint(equalTo: self.purchaseButton.leadingAnchor).isActive = true
        
        artPieceImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: artPieceTopEdgeInset).isActive = true
        artPieceImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -artPieceTrailingEdgeInset).isActive = true
        artPieceImageView.heightAnchor.constraint(equalToConstant: artPieceSize.height).isActive = true
        artPieceImageView.widthAnchor.constraint(equalToConstant: artPieceSize.width).isActive = true
        
        purchaseButton.trailingAnchor.constraint(equalTo: descriptionStackView.trailingAnchor).isActive = true
        purchaseButton.bottomAnchor.constraint(equalTo: artPieceImageView.bottomAnchor, constant: 9).isActive = true
        purchaseButton.heightAnchor.constraint(equalToConstant: purchaseButtonHeight).isActive = true
        
        artPieceFocusGuide.topAnchor.constraint(equalTo: artPieceImageView.topAnchor).isActive = true
        artPieceFocusGuide.trailingAnchor.constraint(equalTo: artPieceImageView.leadingAnchor).isActive = true
        artPieceFocusGuide.bottomAnchor.constraint(equalTo: purchaseButton.bottomAnchor).isActive = true
        artPieceFocusGuide.leadingAnchor.constraint(equalTo: purchaseButton.trailingAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        case artPieceImageView:
            artPieceFocusGuide.preferredFocusEnvironments = [descriptionExpandingLabel]
        default:
            artPieceFocusGuide.preferredFocusEnvironments = []
        }
    }
}
