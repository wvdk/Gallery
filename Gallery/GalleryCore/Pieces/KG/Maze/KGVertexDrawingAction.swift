//
//  KGVertexDrawingAction.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/5/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//


import UIKit

struct KGVertexDrawingAction {
    
    enum ActionType {
        case addition
        case removal
    }
    
    let index: Int
    let vertex: KGVertex
    let type: ActionType
    
    init(vertex: KGVertex, type: ActionType = .addition, index: Int) {
        self.vertex = vertex
        self.type = type
        self.index = index
    }
}
