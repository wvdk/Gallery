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
    
    lazy var artPieceSize = CGSize(width: 880 / 1458 * self.frame.size.width,
                                   height: 497 / 829 * self.frame.size.height)
    lazy var artPieceTopEdgeInset = 147 / 829 * self.frame.size.height
    lazy var artPieceTrailingEdgeInset = 51 / 1458 * self.frame.size.width
    
    static let identifier = "ArtPieceCollectionViewCellIdentifier"
    
    private var artPieceFocusGuide: UIFocusGuide
    private let artPieceImageView: FocusedImageView
    
    private let label: FocusedLabel
    private let button = UIButton.init(type: .system)

    var myNumber: Int? {
        didSet {
            label.text = "ART \(myNumber!)"
        }
    }

    // MARK: - UICollectionViewCell focus setup
    
    override var canBecomeFocused: Bool {
        return false
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        artPieceFocusGuide = UIFocusGuide()
        artPieceImageView = FocusedImageView()

        label = FocusedLabel(frame: CGRect(origin: CGPoint(x: 200, y: 100),
                                           size: CGSize(width: 300, height: 300)))
        
        
        super.init(frame: frame)
        
        self.backgroundColor = .red
        artPieceImageView.image = UIImage(named: "cell")
        
        button.setTitle("the but", for: .normal)
        button.frame = CGRect(origin: CGPoint(x: 100, y: 400),
                              size: CGSize(width: 300, height: 100))
        
        self.addSubview(label)
        self.addSubview(button)
        
        self.addSubview(artPieceImageView)
        self.addLayoutGuide(artPieceFocusGuide)
        
        artPieceImageView.translatesAutoresizingMaskIntoConstraints = false
        
        artPieceImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: artPieceTopEdgeInset).isActive = true
        artPieceImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -artPieceTrailingEdgeInset).isActive = true
        artPieceImageView.heightAnchor.constraint(equalToConstant: artPieceSize.height).isActive = true
        artPieceImageView.widthAnchor.constraint(equalToConstant: artPieceSize.width).isActive = true
        
        artPieceFocusGuide.topAnchor.constraint(equalTo: artPieceImageView.topAnchor).isActive = true
        artPieceFocusGuide.trailingAnchor.constraint(equalTo: artPieceImageView.leadingAnchor).isActive = true
        artPieceFocusGuide.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        artPieceFocusGuide.leadingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
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
        
        guard let nextFocusedView = context.nextFocusedView, let previouslyFocusedView = context.previouslyFocusedView else { return }
        
        switch nextFocusedView {
        case artPieceImageView:
            artPieceFocusGuide.preferredFocusEnvironments = [previouslyFocusedView]
        case button:
            artPieceFocusGuide.preferredFocusEnvironments = [artPieceImageView]
        default:
            artPieceFocusGuide.preferredFocusEnvironments = []
        }
    }
}
