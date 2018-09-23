//
//  GlobalFunctions.swift
//
//  Created by Wesley Van der Klomp on 12/29/17.
//  Copyright © 2017 Wesley Van der Klomp. All rights reserved.
//

import Foundation

/// Produces a random Bool.
public func flipACoin() -> Bool {
    return Bool.random()
}

/// Runs the provided black after a delay.
public func start(_ closure: @escaping () -> (), after delay: TimeInterval) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay, execute: closure)
}
