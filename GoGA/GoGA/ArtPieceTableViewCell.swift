//
//  ArtPieceTableViewCell.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 3/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceTableViewCell: UITableViewCell {

    fileprivate enum Constants {
        static let cellCornerRadius: CGFloat = 5.0
        static let artPieceImageViewLengthRatio: CGFloat = 950.0 / 1024.0
        static let artPieceImageViewHeight: CGFloat = 120.0
    }
    
    static let identifier = "artPieceTableViewCell"
    var artPieceImageView = UIImageView()
    var idLabel = UILabel()
    var titleLabel = UILabel()

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        idLabel.text = "a.000A"
        
        configureView()
    }
    
    func configureView() {
        backgroundColor = .clear
        
        artPieceImageView.with { it in
            contentView.addSubview(it)
            it.backgroundColor = .white
            it.layer.cornerRadius = Constants.cellCornerRadius
            it.translatesAutoresizingMaskIntoConstraints = false
            it.image = UIImage(named: "InDevelopment")
            it.layer.shadowOffset = CGSize(width: 4.0, height: 5.0)
            it.layer.shadowRadius = 4.0
            it.translatesAutoresizingMaskIntoConstraints = false
            it.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 38).isActive = true
            it.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -38).isActive = true
            it.heightAnchor.constraint(equalToConstant: 120).isActive = true
            it.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }        
        
        idLabel.with { it in
            contentView.addSubview(it)
            it.translatesAutoresizingMaskIntoConstraints = false
            it.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2 * 3)
            it.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14).isActive = true
            it.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            it.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .light)
            it.textColor = UIColor(displayP3Red: 0.54, green: 0.54, blue: 0.54, alpha: 1.0)
        }
        
        contentView.addSubview(titleLabel)
    }

}
