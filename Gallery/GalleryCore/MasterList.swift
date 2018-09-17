//
//  MasterList.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/3/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

/// A singleton master list of all art pieces, and only active pieces. The active list is what should be presented to the user.
/// To be informed when it has been received for the first time or updated you should observe the `didUpdateActivePieces` notification via `NotificationCenter.default` and refresh your presentation.
public class MasterList {

    /// The shared reference to the `MasterList` singleton.
    public static let shared = MasterList()
    
    /// Privatized initalizer forcing users of this class should always access via the `shared` property.
    ///
    /// Also starts up the firebase observer.
    private init() {
        // TODO: Removing the firebase stuff because it's not cooperating and that's not the problem I want to solve right now.
        activePieces = [
            ArtMetadata(id: "ThreeColumnBoids", author: "KG", prettyPublishedDate: "September 2018", viewType: KGBoidsThreeColumnsView.self, thumbnail: nil),
            ArtMetadata(id: "FireBoids", author: "KG", prettyPublishedDate: "September 2018", viewType: KGBoidsFireView.self, thumbnail: nil),
            ArtMetadata(id: "A565z", author: "wvdk", prettyPublishedDate: "June 2018", viewType: A565zView.self, thumbnail: UIImage(named: "A565z"))
        ]
    }
    
    public var activePieces = [ArtMetadata]() {
        didSet {
            NotificationCenter.default.post(name: MasterList.didUpdateActivePieces, object: nil, userInfo: nil)
        }
    }
    
    /// A `NotificationCenter.default` notification name which is posted by `MasterList.shared` when the `activePieces` list has been updated.
    public static let didUpdateActivePieces = Notification.Name("masterListDidUpdateActivePieces")
    
}
