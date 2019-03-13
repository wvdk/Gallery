//
//  KGInsertionSortingAlgorithm.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/11/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import Foundation

public class KGInsertionSortingAlgorithm {

    static func sort(_ array: [Int]) -> (sortedArray: [Int], sortingActions: [KGSortingAction]) {
        var actionIndex = 0
        var sortingArray = array
        var sortingActions = [KGSortingAction]()
        
        for index in 1..<sortingArray.count {
            var previousIndex = index - 1
            
            while (previousIndex >= 0 && compare(numberA: sortingArray[previousIndex], numberB: sortingArray[previousIndex + 1]) > 0) {
                sortingArray.swapAt(previousIndex, previousIndex + 1)
                
                let sortingAction = KGSortingAction(actionIndex, start: previousIndex, end: previousIndex + 1)
                sortingActions.append(sortingAction)
                
                previousIndex -= 1
                actionIndex += 1
            }
        }
        
        return (sortingArray, sortingActions)
    }
    
    static func compare(numberA: Int, numberB: Int) -> Int {
        if numberA > numberB {
            return 1
        }
        
        return 0
    }
}
