//
//  MasterList.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit
import FirebaseDatabase

/// A singleton master list of all art pieces, and only active pieces. The active list (which is kept on Firebase) is what should be presented to the user.
/// To be informed when it has been received for the first time or updated you should observe the `didUpdateActivePieces` notification via `NotificationCenter.default` and refresh your presentation.
class MasterList {

    /// The shared reference to the `MasterList` singleton.
    static let shared = MasterList()
    
    /// Privatized initalizer forcing users of this class should always access via the `shared` property.
    ///
    /// Also starts up the firebase observer.
    private init() {
        let ref = Database.database().reference().child("activePieces")
        
        ref.observe(.value) { snapshot in
            if let pieceIds = snapshot.value as? [String] {
                var foundPieces = [ArtPiece]()
                for id in pieceIds {
                    if let foundPiece = self.allPieces.first(where: { $0.id == id }) {
                        foundPieces.append(foundPiece)
                    }
                }
                
                self.activePieces = foundPieces
            } else {
                self.activePieces = []
            }
        }
    }
    
    var activePieces = [ArtPiece]() {
        didSet {
            NotificationCenter.default.post(name: MasterList.didUpdateActivePieces, object: nil, userInfo: nil)
        }
    }

    /// The master list of all the `ArtPiece`s in the project. You'll need to update this list when you create a new one.
    let allPieces: [ArtPiece] = [
        ArtPiece(id: "a.857C", author: "Kristina Gelzinyte", prettyPublishedDate: "May 22", thumbnailImage: #imageLiteral(resourceName: "a857C.png"), viewController: a857CViewController.self),
        ArtPiece(id: "a.994t", author: "wvdk", prettyPublishedDate: "May 21", thumbnailImage: #imageLiteral(resourceName: "a994t.png"), viewController: a994tViewController.self),
        ArtPiece(id: "a.586q", author: "wwvdk", prettyPublishedDate: "May 20", thumbnailImage: #imageLiteral(resourceName: "a586q.png"), viewController: a586qViewController.self),
        ArtPiece(id: "a.736D", author: "wvdk", prettyPublishedDate: "May 19", thumbnailImage: #imageLiteral(resourceName: "a736D.png"), viewController: a736DViewController.self),
        ArtPiece(id: "a.565z", author: "wvdk", prettyPublishedDate: "May 18", thumbnailImage: #imageLiteral(resourceName: "InDevelopment"), viewController: a565zViewController.self)
    ]
    
    /// A `NotificationCenter.default` notification name which is posted by `MasterList.shared` when the `activePieces` list has been updated.
    static let didUpdateActivePieces = Notification.Name("masterListDidUpdateActivePieces")
    
}
