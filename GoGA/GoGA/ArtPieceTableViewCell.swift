//
//  ArtPieceTableViewCell.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 3/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import ArtKit

protocol ArtPieceTableViewCellDelegate {
    
    func openArtPiece(viewController: ArtPieceDetailViewController)
    
}

class ArtPieceTableViewCell: UITableViewCell {
    
    static let identifier = "artPieceTableViewCell"
    var delegate: ArtPieceTableViewCellDelegate? = nil
    var piece: Piece? = nil {
        didSet {
            guard let piece = piece else { return }
            idLabel.text = piece.id
            nameAndDateLabel.text = "\(piece.author), \(piece.prettyDate)"
            previewImageView.image = piece.image
        }
    }
    
    private var previewImageView = UIImageView()
    private var idLabel = UILabel()
    private var nameAndDateLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configureView()
    }
    
    func configureView() {
        backgroundColor = .clear
        
        let containerView = UIView()
        containerView.with { it in
            contentView.addSubview(it)
            it.clipsToBounds = false
            it.backgroundColor = .white
            it.layer.cornerRadius = 8.0
            it.layer.shadowRadius = 4.0
            it.layer.shadowOffset = CGSize(width: 0, height: 2)
            it.layer.shadowColor = UIColor.black.cgColor
            it.layer.shadowOpacity = 0.1
            it.translatesAutoresizingMaskIntoConstraints = false
            it.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 38).isActive = true
            it.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38).isActive = true
            it.heightAnchor.constraint(equalToConstant: 120).isActive = true
            it.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        previewImageView.with { it in
            containerView.addSubview(it)
            it.clipsToBounds = true
            it.layer.cornerRadius = 8.0
            it.contentMode = .scaleAspectFill
            it.translatesAutoresizingMaskIntoConstraints = false
            it.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            it.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
            it.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
            it.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            it.addSingleTapGestureRecognizer { [weak self] _ in
                guard let viewController = self?.piece?.viewController else { return }
                self?.delegate?.openArtPiece(viewController: viewController)
            }
        }        
        
        idLabel.with { it in
            contentView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2 * 3)
            it.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
            it.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            it.font = UIFont(name: "SFMono-Light", size: 12.0)
            it.textColor = UIColor(displayP3Red: 0.54, green: 0.54, blue: 0.54, alpha: 1.0)
        }
        
        nameAndDateLabel.with { it in
            contentView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 2).isActive = true
            it.trailingAnchor.constraint(equalTo: previewImageView.trailingAnchor, constant: -8).isActive = true
            it.font = UIFont(name: "Avenir Next", size: 12)
            it.textColor = UIColor(r: 94, g: 64, b: 64)
        }
    }

}
