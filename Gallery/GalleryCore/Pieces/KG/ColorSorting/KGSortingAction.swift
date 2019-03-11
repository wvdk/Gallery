//
//  KGSortingAction.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/11/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

public struct SortingAction {
    
    let index: Int
    let start: Int
    let end: Int
    
    init(_ index: Int, start: Int, end: Int) {
        self.index = index
        self.start = start
        self.end = end
    }
}
