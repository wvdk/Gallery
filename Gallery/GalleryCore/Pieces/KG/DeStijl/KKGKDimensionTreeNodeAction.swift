//
//  KKGKDimensionTreeNodeAction.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/24/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

struct KKGKDimensionTreeNodeAction {
    
    let index: Int
    let node: KGKDimensionNode
    
    init(node: KGKDimensionNode, index: Int) {
        self.node = node
        self.index = index
    }
}
