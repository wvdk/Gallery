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
    
    static let identifier = "ArtPieceCollectionViewCellIdentifier"
    
    private var focusGuide: UIFocusGuide
    private let label: FocusedLabel
    private let imageView: FocusedImageView
    private let button = UIButton.init(type: .system)

    var myNumber: Int? {
        didSet {
            label.text = "ART \(myNumber!)"
        }
    }
    

    // MARK: - UICollectionViewCell focus setup
    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        return [imageView]
//    }
    
    override var canBecomeFocused: Bool {
        return false
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        focusGuide = UIFocusGuide()

        label = FocusedLabel(frame: CGRect(origin: CGPoint(x: 100, y: 100),
                                           size: CGSize(width: 300, height: 300)))
        
        imageView = FocusedImageView(frame: CGRect(origin: CGPoint(x: 500, y: 100),
                                                   size: CGSize(width: 700, height: 300)))
        
        super.init(frame: frame)
        
        //        self.backgroundColor = .red
       
        imageView.image = UIImage(named: "cell")
        
        button.setTitle("the but", for: .normal)
        button.frame = CGRect(origin: CGPoint(x: 100, y: 500),
                              size: CGSize(width: 300, height: 100))
        
        self.addSubview(imageView)
        self.addSubview(label)
        self.addSubview(button)
        
      
        self.addLayoutGuide(focusGuide)
        
        focusGuide.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        focusGuide.topAnchor.constraint(equalTo: button.topAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: button.heightAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UICollectionViewCell layout setup
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        self.alpha = 0.5
    }
    
    private var viewToRemember: UIView?
    
    // MARK: - UIFocusEnvironment update
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)

        let debugView = FocusGuideDebugView(focusGuide: focusGuide)
        self.addSubview(debugView)
                
        
        guard let nextFocusedView = context.nextFocusedView, let previouslyFocusedView = context.previouslyFocusedView else { return }
        
//        if nextFocusedView == imageView {
//            viewToRemember = previouslyFocusedView
//        }
//
//        switch previouslyFocusedView {
//        case imageView:
//            if let viewToRemember = viewToRemember {
//                focusGuide.preferredFocusEnvironments = [viewToRemember]
//                self.viewToRemember = nil
//            }
//
//        case button:
//            focusGuide.preferredFocusEnvironments = [imageView]
//
//        default:
//            focusGuide.preferredFocusEnvironments = []
//        }
        
      
        switch nextFocusedView {
        case imageView:
            focusGuide.preferredFocusEnvironments = [button]
        case button:
            focusGuide.preferredFocusEnvironments = [imageView]
        default:
            focusGuide.preferredFocusEnvironments = []
        }
    }
}

class FocusGuideDebugView: UIView {
    
    init(focusGuide: UIFocusGuide) {
        super.init(frame: focusGuide.layoutFrame)
        backgroundColor = UIColor.green.withAlphaComponent(0.15)
        layer.borderColor = UIColor.green.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
