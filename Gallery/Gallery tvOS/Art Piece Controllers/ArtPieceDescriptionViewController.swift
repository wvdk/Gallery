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
    private let descriptionLabel = BodyLabel(color: .white)
    
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
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .justified
        
        updateDescriptionText()
        
        let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        let stackView = setupDescriptionStackView()
        
        view.addSubview(backgroundView)
        view.addSubview(stackView)
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundView.constraint(edgesTo: view)

        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -100).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 500).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
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
    
    private func updateDescriptionText() {
        authorNameLabel.text = "\(artPieceMetadata.author)"
        dateLabel.text = "\(artPieceMetadata.prettyPublishedDate)"
        titleLabel.text = "\(artPieceMetadata.id)"
        
        if let description = artPieceMetadata.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.text = "Lorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquamorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam \nLorem ipsum dolor sit amet, ligula suspendisse nulla pretium, rhoncus tempor fermentum, enim integer ad vestibulum volutpat. Nisl rhoncus turpis est, vel elit, congue wisi enim nunc ultricies sit, magna tincidunt. Maecenas aliquam. gna tincidunt. Maecenas aliquam tincidunt. Maecenas aliquam"
        }
    }
}
