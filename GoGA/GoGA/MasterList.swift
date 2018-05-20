//
//  MasterList.swift
//  GoGA
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit
import FirebaseDatabase

/// A singleton master list of art pieces.
///
/// To be informed when it has been received for the first time or updated you should observe the `` via NotificationCenter, which includes a copy of the new list in it's userInfo under the "masterList" key.
class MasterList {

    /// The shared reference to the `MasterList` singleton.
    static let shared = MasterList()
    
    /// Privatized initalizer forcing users of this class should always access via the `shared` property.
    ///
    /// Also starts up the firebase observer.
    private init() {
        let ref = Database.database().reference().child("masterList")
        
        ref.observe(.value) { snapshot in
            print(snapshot)
            // TODO: parse snapshot and update `pieces`
        }
    }

    /// <#Description#>
    let pieces: Array<ArtPiece> = [
        ArtPiece(id: "a.857C", author: "Kristina Gelzinyte", date: Date(), image: #imageLiteral(resourceName: "a857C.png"), viewController: a857CViewController.self),
        ArtPiece(id: "a.994t", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a994t.png"), viewController: a994tViewController.self),
        ArtPiece(id: "a.586q", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a586q.png"), viewController: a586qViewController.self),
        ArtPiece(id: "a.736D", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a736D.png"), viewController: a736DViewController.self),
        ArtPiece(id: "a.565z", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "InDevelopment"), viewController: a565zViewController.self)
    ]
    
    /// <#Description#>
    static let didUpdateNotificationName = Notification.Name("masterListDidUpdate")
    
}

/// <#Description#>
struct ArtPiece {
    
    /// The unique ID for this ArtPiece. These are generated using `IDGenerator`.
    let id: String
    
    /// <#Description#>
    let author: String
    
    /// <#Description#>
    let date: Date
    
    /// <#Description#>
    let image: UIImage
    
    /// <#Description#>
    let viewController: ArtPieceDetailViewController.Type
    
    /// <#Description#>
    var prettyDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    /// Initializer which takes a Firebase `DataSnapshot`.
    ///
    /// - Parameter snapshot: A `DataSnapshot` which should be parsed into an `ArtPiece`.
    init?(snapshot: DataSnapshot) {
        self.id = ""
        self.author = ""
        self.date = Date()
        self.image = UIImage()
        self.viewController = ArtPieceDetailViewController.self
    }
    
    init(id: String, author: String, date: Date, image: UIImage, viewController: ArtPieceDetailViewController.Type) {
        self.id = id
        self.author = author
        self.date = date
        self.image = image
        self.viewController = viewController
    }
    
}
