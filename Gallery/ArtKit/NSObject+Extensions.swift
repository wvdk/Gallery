//
//  NSObject+Extensions.swift
//  Gallery
//
//  Created by Wesley Van der Klomp on 3/1/18.
//  Copyright © 2018 Gallery. All rights reserved.
//

import Foundation

public protocol WithProtocol {}

extension NSObject: WithProtocol {}

extension WithProtocol where Self: NSObject {
    
    public func with(closure: (Self) -> Void) {
        closure(self)
    }
    
}
