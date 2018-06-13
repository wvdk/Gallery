//
//  IDGenerator.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/3/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import Foundation

struct IDGenerator {
    
    fileprivate enum Constants {
        static let allLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        static let allDigits = "0123456789"
        static let uniqueIDBeggining = "a."
    }    

    func generateNewArtPieceID() -> String {
        let newId = generate(digits: 3, letters: 1)
        
        if (MasterList.shared.activePieces.contains { $0.id == newId }) {
            return generateNewArtPieceID()
        }
        
        return newId
    }
    
    func generate(digits: Int, letters: Int) -> String {
        var uniqueId = Constants.uniqueIDBeggining
        let randomNumber = random(of: Constants.allDigits, for: digits)
        let randomletter = random(of: Constants.allLetters, for: letters)
        uniqueId.append(randomNumber)
        uniqueId.append(randomletter)
        return uniqueId
    }
    
    private func random(of collection: String, for numberTimes: Int) -> String {
        var randomGeneratedString = ""
        for _ in 0..<numberTimes {
            let count = UInt32(collection.count)
            let randomCountNumber = Int(arc4random_uniform(count))
            let randomIndex = collection.index(collection.startIndex, offsetBy: randomCountNumber)
            randomGeneratedString.append(collection[randomIndex])
        }
        return randomGeneratedString
    }
    
}
