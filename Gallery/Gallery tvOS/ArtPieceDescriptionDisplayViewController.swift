//
//  ArtPieceDescriptionDisplayViewController.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 8/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

/// A subclass of `UIViewController`, which displays art piece info.
///
/// - Author name.
/// - Title.
/// - Publishing date.
/// - Description.
class ArtPieceDescriptionDisplayViewController: UIViewController {

    // MARK: - Properties
    
    private var artPieceMetadata: ArtMetadata
    
    private let authorNameLabel = HeadlineLabel(color: .white, isFontBold: true)
    private let titleLabel = BodyLabel(color: .white)
    private let dateLabel = BodyLabel(color: .white)
    private let descriptionTextView = DescriptionTextView()
    
    // MARK: - Initialization
    
    /// Initializes and returns a newly allocated view object with the specified `artMetadata` art piece description view.
    ///
    /// - Parameters:
    ///     - artMetadata: Metadata of the art piece, which description view will to be presented.
    ///
    /// - Returns: `UIViewController` with child view of art piece description.
    init(artMetadata: ArtMetadata) {
        self.artPieceMetadata = artMetadata
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets background view to dark blur `UIVisualEffectView`.
        let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        view.addSubview(backgroundView)
        view.addSubview(authorNameLabel)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionTextView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.constraint(edgesTo: view)
        
        authorNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 170).isActive = true
        authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -500).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true

        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor, constant: 25).isActive = true
        descriptionTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120).isActive = true
        
        updateText()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Scrolls description text view to the top of the `UITextView`.
        descriptionTextView.setContentOffset(.zero, animated: false)
    }

    // MARK: - Description text update
    
    /// Sets art piece info label text.
    private func updateText() {
        authorNameLabel.text = "\(artPieceMetadata.author)"
        dateLabel.text = "\(artPieceMetadata.prettyPublishedDate)"
        titleLabel.text = "\(artPieceMetadata.id)"
        descriptionTextView.text = artPieceMetadata.description ?? ""
    }
}
