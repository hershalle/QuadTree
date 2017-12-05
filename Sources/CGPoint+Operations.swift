//
//  CGPoint+Operations.swift
//  QuadTree
//
//  Created by Shai Balassiano on 04/12/2017.
//  Copyright © 2017 hershalle. All rights reserved.
//

import UIKit

@inline(__always)
func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

func < (lhs: CGPoint, rhs: CGPoint) -> Bool {
    return lhs.x < rhs.x && lhs.y < rhs.y
}


@inline(__always)
func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint  {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

@inline(__always)
func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint  {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

@inline(__always)
func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint  {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

@inline(__always)
func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint  {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

@inline(__always)
func += (lhs: inout CGPoint, rhs: CGPoint)  {
    lhs = lhs + rhs
}

@inline(__always)
func -= (lhs: inout CGPoint, rhs: CGPoint)  {
    lhs = lhs - rhs
}

@inline(__always)
func *= (lhs: inout CGPoint, rhs: CGFloat)  {
    lhs = lhs * rhs
}

@inline(__always)
func /= (lhs: inout CGPoint, rhs: CGFloat)  {
    lhs = lhs / rhs
}

