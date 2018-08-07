//
//  NotFocusingCollectionView.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// An object that manages an ordered collection of data items with disabled focus property.
class NotFocusingCollectionView: UICollectionView {

    override var canBecomeFocused: Bool {
        return false
    }
}
