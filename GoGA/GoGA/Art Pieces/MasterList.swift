//
//  MasterList.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import FirebaseDatabase

/// A singleton master list of all art pieces, and only active pieces. The active list (which is kept on Firebase) is what should be presented to the user.
/// To be informed when it has been received for the first time or updated you should observe the `didUpdate` notification via `NotificationCenter.default` and refresh your presentation.
class MasterList {

    /// The shared reference to the `MasterList` singleton.
    static let shared = MasterList()
    
    /// Privatized initalizer forcing users of this class should always access via the `shared` property.
    ///
    /// Also starts up the firebase observer.
    private init() {
        let ref = Database.database().reference().child("activePieces")

        ref.setValue( allPieces.map { $0.id } )
        
//        ref.observe(.value) { snapshot in
//            print(snapshot)
//            // TODO: parse snapshot, update `allPieces`, and push notification
//        }
    }

    /// The master list of all the `ArtPiece`s in the project. You'll need to update this list when you create a new one.
    let allPieces: [ArtPiece] = [
        ArtPiece(id: "a.857C", author: "Kristina Gelzinyte", prettyPublishedDate: "May 22", thumbnailImage: #imageLiteral(resourceName: "a857C.png"), viewController: a857CViewController.self),
        ArtPiece(id: "a.994t", author: "wvdk", prettyPublishedDate: "May 21", thumbnailImage: #imageLiteral(resourceName: "a994t.png"), viewController: a994tViewController.self),
        ArtPiece(id: "a.586q", author: "wwvdk", prettyPublishedDate: "May 20", thumbnailImage: #imageLiteral(resourceName: "a586q.png"), viewController: a586qViewController.self),
        ArtPiece(id: "a.736D", author: "wvdk", prettyPublishedDate: "May 19", thumbnailImage: #imageLiteral(resourceName: "a736D.png"), viewController: a736DViewController.self),
        ArtPiece(id: "a.565z", author: "wvdk", prettyPublishedDate: "May 18", thumbnailImage: #imageLiteral(resourceName: "InDevelopment"), viewController: a565zViewController.self)
    ]
    
    /// <#Description#>
    static let didUpdate = Notification.Name("masterListDidUpdate")
    
}
