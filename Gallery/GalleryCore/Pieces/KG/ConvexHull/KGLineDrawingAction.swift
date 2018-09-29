//
//  KGLineDrawingAction.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 9/27/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

struct KGLineDrawingAction {
    
    enum ActionType {
        case addition
        case removal
    }
    
    let index: Int
    let line: KGLine
    let type: ActionType
    
    init(line: KGLine, type: ActionType, index: Int) {
        self.line = line
        self.type = type
        self.index = index
    }
}
