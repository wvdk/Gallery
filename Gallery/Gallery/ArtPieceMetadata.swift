//
//  ArtPieceMetadata.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 5/21/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

typealias ArtPieceId = String

/// A struct which represents an art piece for display in this gallery.
struct ArtPieceMetadata {
    
    /// The unique ID for this ArtPiece. These are generated using `IDGenerator`.
    let id: ArtPieceId
    
    /// The name of the person who created this piece.
    let author: String
    
    /// The date at which this piece as released (might only retain accuracy up to the month - not day).
    var published: Date
    
    /// A computed property returning a pretty formatted string of the `published` date.
    var prettyPublishedDate: String {
        return ArtPieceMetadata.dateFormatter.string(from: self.published)
    }
    
    /// The Type of the view controller which contains this art piece for display. Must be initiallized seperately.
//    @available(*, deprecated)
//    let viewController: ArtPieceDetailViewController.Type
    
    /// The Type of the view which contains all the content of this art piece.
    var viewType: ArtPieceView.Type
    
    weak var view: ArtPieceView? = nil
    
    /// A static `DateFormatter` used for converting "March 2018" style `string`s into and out of `Date` objects.
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    /// Creates an instance of the `ArtPieceMetadata` struct.
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - author: <#author description#>
    ///   - prettyPublishedDate: Formatted MMMM yyyy (e.g. June 2018)
    ///   - viewType: <#viewType description#>
    init(id: ArtPieceId, author: String, prettyPublishedDate: String, viewType: ArtPieceView.Type) {
        self.id = id
        self.author = author
        self.published = ArtPieceMetadata.dateFormatter.date(from: prettyPublishedDate) ?? Date()
//        self.viewController = viewController
        self.viewType = viewType
    }
    
}

