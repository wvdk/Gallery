//
//  KGQueue.swift
//  Gallery
//
//  Created by Kristina Gelzinyte on 10/5/18.
//  Copyright © 2018 Gallery of Generative Art. All rights reserved.
//

import UIKit

/// A queue - array type object to store queues.
public struct KGQueue<T> {
    
    // MARK: - Private properties
    
    /// An array to store queues.
    private var array: [T]
    
    // MARK: - Public properties
    
    /// Returns true if queus list is empty.
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    /// Returns first queue in the list.
    var first: T? {
        return array.first
    }
    
    /// Returns queue list as an array of `Vertex` type object.
    var vertexList: [KGVertex]? {
        return array as? [KGVertex]
    }
    
    /// Returns smallest distance `Vertex`.
    var smallest: KGVertex? {
        if let vertexArray = array as? [KGVertex] {
            return vertexArray.min { (a, b) in
                a.distance < b.distance
            }
        }
        return first as? KGVertex
    }
    
    // MARK: - Initialization
    
    /// Initializes empty queue list.
    init() {
        array = []
    }
    
    // MARK: - Queue list update
    
    /// Adds an element to the end of the queue.
    ///
    /// - Parameters:
    ///     - element: An element to be added to the queue.
    mutating func push(_ element: T) {
        array.append(element)
    }
    
    /// Removes first queue object in the queue list.
    @discardableResult mutating func pop() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    /// Removes specified queue object in the list.
    ///
    /// - Parameters:
    ///     - vertex: An object of a type `Vertex` to be removed from the queue list.
    mutating func pop(vertex: KGVertex) {
        if !isEmpty, let vertexArray = array as? [KGVertex], let index = vertexArray.firstIndex(where: { $0 == vertex }) {
            array.remove(at: index)
        }
    }
}
