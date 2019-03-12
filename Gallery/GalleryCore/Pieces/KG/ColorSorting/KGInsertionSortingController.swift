//
//  KGInsertionSortingController.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 3/11/19.
//  Copyright © 2019 Gallery of Generative Art. All rights reserved.
//

import Foundation

public class SortingController {
    
    private(set) var unsortedArray = [[Int]]()
    private(set) var sortedArray = [[Int]]()
    private(set) var sortingActions = [[SortingAction]]()
    
    init(sortingMatrixSize: KGColorSortingView.MatrixSize) {
        self.unsortedArray = []
        self.sortedArray = []
        self.sortingActions = []
        
        for _ in 0...sortingMatrixSize.columns {
            let unsorted = self.generateUnsortedArray(of: sortingMatrixSize.rows)
            let sortingResult = InsertionSortingAlgorithm.sort(unsorted)
            
            unsortedArray.append(unsorted)
            sortedArray.append(sortingResult.sortedArray)
            sortingActions.append(sortingResult.sortingActions)
        }
    }
    
    private func generateUnsortedArray(of size: Int) -> [Int] {
        return Array(0...size).shuffled()
    }
}

