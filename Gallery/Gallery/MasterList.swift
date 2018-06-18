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
//        let ref = Database.database().reference().child("activePieces")
//
//        ref.observe(.value) { snapshot in
//            if let pieceIds = snapshot.value as? [String] {
//                var foundPieces = [ArtMetadata]()
//                for id in pieceIds {
//                    if let foundPiece = self.allPieces.first(where: { $0.id == id }) {
//                        foundPieces.append(foundPiece)
//                    }
//                }
//
//                self.activePieces = foundPieces
//            } else {
//                self.activePieces = []
//            }
//        }
        
        // TODO: Removing the firebase stuff because it's not cooperating and that's not the problem I want to solve right now.
        activePieces = [ArtMetadata(id: "a.565z", author: "wvdk", prettyPublishedDate: "June 2018", viewType: A565zView.self)]
    }
    
    var activePieces = [ArtMetadata]() {
        didSet {
            NotificationCenter.default.post(name: MasterList.didUpdateActivePieces, object: nil, userInfo: nil)
        }
    }
    
    /// A `NotificationCenter.default` notification name which is posted by `MasterList.shared` when the `activePieces` list has been updated.
    static let didUpdateActivePieces = Notification.Name("masterListDidUpdateActivePieces")
    
}
