//
//  MasterList.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import Foundation

/// A master list of art pieces.
struct MasterList {

    static let pieces = [
        Piece(id: "a.736D", author: "wvdk", date: Date(), viewController: a736DViewController())
    ]
    
}

struct Piece {
    let id: String
    let author: String
    let date: Date
    let viewController: ArtPieceDetailViewController
}
