//
//  DisabledFocusCollectionView.swift
//  Gallery TV
//
//  Created by Kristina Gelzinyte on 8/6/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A subclass of `UICollectionView`.
///
/// Returns collection view with disabled focus property.
class DisabledFocusCollectionView: UICollectionView {

    /// Disables can become focused property to pass focus environment to child views.
    override var canBecomeFocused: Bool {
        return false
    }
}
