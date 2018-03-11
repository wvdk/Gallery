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
        configureView()
    }
    
    func configureView() {
//        backgroundColor = .black
        
//        artPieceImageView.with { it in
//            contentView.addSubview(it)
//            it.backgroundColor = .red
//            it.layer.cornerRadius = Constants.cellCornerRadius
////            it.layer.shadowOffset = CGSize(width: 4.0, height: 5.0)
////            it.layer.shadowRadius = 4.0
////            it.translatesAutoresizingMaskIntoConstraints = false
//            it.frame.size = CGSize(width: self.frame.size.width * Constants.artPieceImageViewLengthRatio,
//                                   height: Constants.artPieceImageViewHeight)
//            it.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
////            it.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        }
        
        
        idLabel.with { it in
            contentView.addSubview(idLabel)
            it.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            it.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        }
        
        contentView.addSubview(titleLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
