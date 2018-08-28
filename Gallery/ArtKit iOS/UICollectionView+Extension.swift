//
//  UICollectionView+Extension.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 8/1/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

extension UICollectionView {
    
    /// Returns `IndexPath` of first `item` in first `section`.
    public var firstCellIndex: IndexPath {
        return IndexPath(item: 0, section: 0)
    }
    
    /// Returns selected collection view cell of visible cell list.
    public var selectedCell: UICollectionViewCell? {
        for cell in visibleCells {
            if cell.isSelected {
                return cell
            }
        }
        return nil
    }
    
    /// Selects the item at the specified index path.
    public func selectCell(at indexPath: IndexPath, animated: Bool = false, scrollPosition: UICollectionView.ScrollPosition = .bottom) {
        self.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }
    
    /// Deselects all items in collection view.
    public func deselectAllItems(animated: Bool = false) {
        self.indexPathsForSelectedItems?.forEach { self.deselectItem(at: $0, animated: animated) }
    }
}
