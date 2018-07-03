//
//  CustomOperators.swift
//  GalleryCore iOS
//
//  Created by Kristina Gelzinyte on 7/3/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import Foundation

precedencegroup RandomAdditionOrSubtractionPrecedence {
    lowerThan: AdditionPrecedence
    associativity: left
}

infix operator +||-: RandomAdditionOrSubtractionPrecedence
