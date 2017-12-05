//
//  QuadTree.swift
//  QuadTree
//
//  Created by Shai Balassiano on 03/12/2017.
//  Copyright © 2017 hershalle. All rights reserved.
//

import UIKit

enum QuadTreeNode<T> {
    case leaf(point: CGPoint, object: T)
    indirect case children(northWest: QuadTree<T>, northEast: QuadTree<T>, southWest: QuadTree<T>, southEast: QuadTree<T>)
}

public class QuadTree<T> {
    
    private(set) var node: QuadTreeNode<T>?
    
    public let minimumSize: CGSize
    public let bounds: CGRect
    
    public init(bounds: CGRect, minimumSize: CGSize) {
        self.bounds = bounds
        self.minimumSize = minimumSize
    }
    
    public var isEmpty: Bool {
        return node == nil
    }
    
    func canSubdevide() -> Bool {
        return bounds.size.width / 2 >= minimumSize.width && bounds.size.height / 2 >= minimumSize.height
    }
    
    private func uniqueLeaves(from leaves: [(point: CGPoint, object: T)]) -> [(point: CGPoint, object: T)] {
        let sortedLeaves = leaves.sorted { (leaf1, leaf2) -> Bool in
            return leaf1.point < leaf2.point
        }
        
        var filteredLeaves = [(point: CGPoint, object: T)]()
        for leaf in sortedLeaves {
            guard filteredLeaves.last?.point != leaf.point else {
                continue
            }
            
            filteredLeaves.append(leaf)
        }
        
        return filteredLeaves
    }
    
    public func add(point: CGPoint, object: T) {
        guard bounds.contains(point) else {
            return
        }
        
        guard let node = node else {
            self.node = .leaf(point: point, object: object)
            return
        }
        
        switch node {
        case .leaf(let leafPoint, let leafObject):
            guard leafPoint != point, canSubdevide() else {
                return
            }
            
            let northWest = QuadTree(bounds: bounds.northWestRect, minimumSize: minimumSize)
            let northEast = QuadTree(bounds: bounds.northEastRect, minimumSize: minimumSize)
            let southWest = QuadTree(bounds: bounds.southWestRect, minimumSize: minimumSize)
            let southEast = QuadTree(bounds: bounds.southEastRect, minimumSize: minimumSize)
            
            self.node = .children(northWest: northWest, northEast: northEast, southWest: southWest, southEast: southEast)
            
            add(point: leafPoint, object: leafObject)
            add(point: point, object: object)
        case .children(northWest: let northWest, northEast: let northEast, southWest: let southWest, southEast: let southEast):
            
            northWest.add(point: point, object: object)
            northEast.add(point: point, object: object)
            southWest.add(point: point, object: object)
            southEast.add(point: point, object: object)
        }
    }
    
    public func leaves() -> [(point: CGPoint, object: T)] {
        guard let node = node else {
            return []
        }
        
        switch node {
        case .leaf(let point, let object):
            return [(point: point, object: object)]
        case .children(northWest: let northWest, northEast: let northEast, southWest: let southWest, southEast: let southEast):
            return northWest.leaves() + northEast.leaves() + southWest.leaves() + southEast.leaves()
        }
    }
    
    public func traverse(action: (_ leaf: (point: CGPoint, object: T)?, _ bounds: CGRect) -> ()) {
        guard let node = node else {
            action(nil, bounds)
            return
        }
        
        switch node {
        case .leaf(let point, let object):
            action((point: point, object: object), bounds)
        case .children(northWest: let northWest, northEast: let northEast, southWest: let southWest, southEast: let southEast):
            northWest.traverse(action: action)
            northEast.traverse(action: action)
            southWest.traverse(action: action)
            southEast.traverse(action: action)
        }
    }
}
