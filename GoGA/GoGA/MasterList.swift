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
        Piece(id: "a.857C", author: "Kristina Gelzinyte", date: Date(), image: #imageLiteral(resourceName: "a857C.png"), viewController: a857CViewController()),
        Piece(id: "a.994t", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "InDevelopment"), viewController: a994tViewController()),
        Piece(id: "a.586q", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a586q.png"), viewController: a586qViewController()),
        Piece(id: "a.736D", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a736D.png"), viewController: a736DViewController())
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
