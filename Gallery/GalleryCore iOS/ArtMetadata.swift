//
//  ArtMetadata.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 5/21/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import UIKit

/// A struct which represents an art piece for display in this gallery.
public struct ArtMetadata {
    
    /// The unique ID for this ArtPiece. These are generated using `IDGenerator`.
    public let id: ArtID
    
    /// The name of the person who created this piece.
    public let author: String
    
    /// The date at which this piece as released (might only retain accuracy up to the month - not day).
    public var published: Date
    
    /// The description of this piece.
    public var description: String?
    
    /// The price of this piece.
    public var price: Double?
    
    /// A computed property returning a pretty formatted string of the `published` date.
    public var prettyPublishedDate: String {
        return ArtMetadata.dateFormatter.string(from: self.published)
    }
    
    /// The Type of the view which contains all the content of this art piece.
    public var viewType: ArtView.Type
    
    /// <#Description#>
    public var view: ArtView? = nil
    
    /// Thumbnail image of the art piece.
    public var thumbnail: UIImage?
    
    /// A static `DateFormatter` used for converting "March 2018" style `string`s into and out of `Date` objects.
    public static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    /// Creates an instance of the `ArtMetadata` struct.
    ///
    /// - Parameters:
    ///   - id: <#id description#>
    ///   - author: <#author description#>
    ///   - description: <#description description#>
    ///   - price: <#price description#>
    ///   - prettyPublishedDate: Formatted MMMM yyyy (e.g. June 2018)
    ///   - viewType: <#viewType description#>
    ///   - thumbnail: <#thumbnail description#>
    public init(id: ArtID, author: String, prettyPublishedDate: String, description: String? = nil, price: Double? = nil, viewType: ArtView.Type, thumbnail: UIImage?) {
        self.id = id
        self.author = author
        self.published = ArtMetadata.dateFormatter.date(from: prettyPublishedDate) ?? Date()
        self.description = description
        self.price = price
//        self.viewController = viewController
        self.viewType = viewType
        self.thumbnail = thumbnail
    }
}
