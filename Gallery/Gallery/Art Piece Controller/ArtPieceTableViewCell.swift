//
//  ArtPieceTableViewCell.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/11/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import ArtKit

protocol ArtPieceTableViewCellDelegate {
    
    func openArtPiece(_ artPiece: ArtPieceMetadata, at originView: UIView)
    
}

class ArtPieceTableViewCell: UITableViewCell {
    
    static let identifier = "artPieceTableViewCell"
    
    var delegate: ArtPieceTableViewCellDelegate? = nil
    
    var piece: ArtPieceMetadata? = nil {
        didSet {
            guard let piece = piece else { return }
            idLabel.text = piece.id
            nameAndDateLabel.text = "\(piece.author), \(piece.prettyPublishedDate)"
            
            if let preexistingView = piece.view {
                self.piece?.view = preexistingView
                self.previewContainerView = preexistingView
            } else {
                let artPieceView = piece.viewType.init(frame: previewContainerView.frame, artPieceMetadata: piece)
                
                previewContainerView.addSubview(artPieceView)
                artPieceView.translatesAutoresizingMaskIntoConstraints = false
                artPieceView.topAnchor.constraint(equalTo: previewContainerView.topAnchor).isActive = true
                artPieceView.bottomAnchor.constraint(equalTo: previewContainerView.bottomAnchor).isActive = true
                artPieceView.leadingAnchor.constraint(equalTo: previewContainerView.leadingAnchor).isActive = true
                artPieceView.trailingAnchor.constraint(equalTo: previewContainerView.trailingAnchor).isActive = true
                
                self.piece?.view = artPieceView
            }
        }
    }
    
    private var previewContainerView = UIView()
    private var idLabel = UILabel()
    private var nameAndDateLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        
        let containerView = UIView()
        contentView.addSubview(containerView)
        containerView.clipsToBounds = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8.0
        containerView.layer.shadowRadius = 4.0
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.1
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 38).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        containerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        containerView.addSubview(previewContainerView)
        previewContainerView.clipsToBounds = true
        previewContainerView.layer.cornerRadius = 8.0
        previewContainerView.contentMode = .scaleAspectFill
        previewContainerView.translatesAutoresizingMaskIntoConstraints = false
        previewContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        previewContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        previewContainerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        previewContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        previewContainerView.tag = 2
        previewContainerView.addSingleTapGestureRecognizer { [weak self] _ in
            guard let piece = self?.piece, let previewContainerView = self?.previewContainerView else { return }
            self?.delegate?.openArtPiece(piece, at: previewContainerView)
        }
        
        contentView.addSubview(idLabel)
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2 * 3)
        idLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        idLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        idLabel.font = UIFont(name: "SFMono-Light", size: 12.0)
        idLabel.textColor = UIColor(displayP3Red: 0.54, green: 0.54, blue: 0.54, alpha: 1.0)
        
        contentView.addSubview(nameAndDateLabel)
        nameAndDateLabel.translatesAutoresizingMaskIntoConstraints = false
        nameAndDateLabel.topAnchor.constraint(equalTo: previewContainerView.bottomAnchor, constant: 2).isActive = true
        nameAndDateLabel.trailingAnchor.constraint(equalTo: previewContainerView.trailingAnchor, constant: -8).isActive = true
        nameAndDateLabel.font = UIFont(name: "Avenir Next", size: 12)
        nameAndDateLabel.textColor = UIColor(r: 94, g: 64, b: 64)
    }
    
}
