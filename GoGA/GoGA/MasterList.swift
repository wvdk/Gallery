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
        }
        
    }

    /// <#Description#>
    let pieces = [
        Piece(id: "a.565z", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "InDevelopment"), viewController: a565zViewController.self),
        Piece(id: "a.857C", author: "Kristina Gelzinyte", date: Date(), image: #imageLiteral(resourceName: "a857C.png"), viewController: a857CViewController.self),
        Piece(id: "a.994t", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a994t.png"), viewController: a994tViewController.self),
        Piece(id: "a.586q", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a586q.png"), viewController: a586qViewController.self),
        Piece(id: "a.736D", author: "Wes Van der Klomp", date: Date(), image: #imageLiteral(resourceName: "a736D.png"), viewController: a736DViewController.self)
    ]
    
    /// <#Description#>
    static let didUpdateNotificationName = Notification.Name("masterListDidUpdate")
    
}

struct Piece {
    
    let id: String
    let author: String
    let date: Date
    let image: UIImage
    let viewController: ArtPieceDetailViewController.Type
    
    var prettyDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
}
