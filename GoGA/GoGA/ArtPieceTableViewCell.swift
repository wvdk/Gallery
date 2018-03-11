//
//  ArtPieceTableViewCell.swift
//  GoGA
//
//  Created by Kristina Gelzinyte on 3/11/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

class ArtPieceTableViewCell: UITableViewCell {

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
//        backgroundColor = .white
        
        contentView.addSubview(artPieceImageView)
        
        contentView.addSubview(idLabel)
        
        contentView.addSubview(titleLabel)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
