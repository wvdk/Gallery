//
//  KGInsertionSortingController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/11/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import Foundation

public class KGInsertionSortingController {
    
    private(set) var unsortedArray = [[Int]]()
    private(set) var sortedArray = [[Int]]()
    private(set) var sortingActions = [[KGSortingAction]]()
    
    init(sortingMatrixSize: KGColorSortingView.MatrixSize) {
        self.unsortedArray = []
        self.sortedArray = []
        self.sortingActions = []
        
        for _ in 0...sortingMatrixSize.columns {
            let unsorted = self.generateUnsortedArray(of: sortingMatrixSize.rows)
            let sortingResult = KGInsertionSortingAlgorithm.sort(unsorted)
            
            unsortedArray.append(unsorted)
            sortedArray.append(sortingResult.sortedArray)
            sortingActions.append(sortingResult.sortingActions)
        }
    }
    
    private func generateUnsortedArray(of size: Int) -> [Int] {
        return Array(0...size).shuffled()
    }
}

