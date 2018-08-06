//
//  ArtPieceDescriptionViewController.swift
//  Gallery iOS
//
//  Created by Kristina Gelzinyte on 8/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import GalleryCore_tvOS

class ArtPieceDescriptionViewController: UIViewController {

    // MARK: - Properties
    
    private var artPieceMetadata: ArtMetadata
    
    private let authorNameLabel = HeadlineLabel(color: .white, isFontBold: true)
    private let titleLabel = BodyLabel(color: .white)
    private let dateLabel = BodyLabel(color: .white)
    private let descriptionLabel = DescriptionTextView()
    
    // MARK: - Initialization
    
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
        
        let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        view.addSubview(backgroundView)
        view.addSubview(authorNameLabel)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        authorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.constraint(edgesTo: view)
        
        authorNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        authorNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -500).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: authorNameLabel.bottomAnchor, constant: 30).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true

        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        
        updateText()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        descriptionLabel.setContentOffset(.zero, animated: false)
    }

    // MARK: - Description text update
    
    private func updateText() {
        authorNameLabel.text = "\(artPieceMetadata.author)"
        dateLabel.text = "\(artPieceMetadata.prettyPublishedDate)"
        titleLabel.text = "\(artPieceMetadata.id)"
        
        if let description = artPieceMetadata.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "START Lorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \n\nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \n\nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \n\nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \n\nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \n\nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \n\nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas END"
        }        
    }
}
