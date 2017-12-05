//
//  CGRect+QuadRegion.swift
//  QuadTree
//
//  Created by Shai Balassiano on 04/12/2017.
//  Copyright © 2017 hershalle. All rights reserved.
//

import UIKit

extension CGRect {
    var northWestRect: CGRect {
        return CGRect(x: origin.x, y: origin.y, width: width / 2, height: height / 2)
    }
    var northEastRect: CGRect {
        return CGRect(x: origin.x + width / 2, y: origin.y, width: width / 2, height: height / 2)
    }
    var southWestRect: CGRect {
        return CGRect(x: origin.x, y: origin.y + height / 2, width: width / 2, height: height / 2)
    }
    var southEastRect: CGRect {
        return CGRect(x: origin.x + width / 2, y: origin.y + height / 2, width: width / 2, height: height / 2)
    }
}
