//
//  UICollectionView+Extension.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

extension UICollectionView {
    
    public var firstCellIndex: IndexPath {
        return IndexPath(item: 0, section: 0)
    }
    
    public func selectCell(at indexPath: IndexPath, animated: Bool = false, scrollPosition: UICollectionViewScrollPosition = .bottom) {
        self.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    public func deselectAllItems(animated: Bool = false) {
        self.indexPathsForSelectedItems?.forEach { self.deselectItem(at: $0, animated: animated) }
    }
}
