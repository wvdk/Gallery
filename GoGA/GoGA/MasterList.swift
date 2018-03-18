//
//  MasterList.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import Foundation
import UIKit

/// A master list of art pieces.
struct MasterList {

    static let pieces = [
        Piece(id: "a.736D", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a736D.png"), viewController: a736DViewController()),
        Piece(id: "a.857C", author: "Kristina Gelzinyte", date: Date(), image: #imageLiteral(resourceName: "a857C.png"), viewController: a857CViewController())
    ]
    
}

struct Piece {
    
    let id: String
    let author: String
    let date: Date
    let image: UIImage
    let viewController: ArtPieceDetailViewController
    
    var prettyDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
}
