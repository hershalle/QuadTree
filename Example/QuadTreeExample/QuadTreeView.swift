//
//  QuadTreeView.swift
//  QuadTreeExample
//
//  Created by Shai Balassiano on 03/12/2017.
//  Copyright © 2017 hershalle. All rights reserved.
//

import UIKit
import QuadTree

class QuadTreeView: UIView {
    
    var quadTree: QuadTree<String>!
    static let circleDiameter: CGFloat = 4
    let minimumSize = CGSize(width: circleDiameter, height: circleDiameter)

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        quadTree = QuadTree<String>(bounds: bounds, minimumSize: minimumSize)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognized(tapGesture:)))
        addGestureRecognizer(tapGesture)
    }

    @objc func didRecognized(tapGesture: UITapGestureRecognizer) {
        quadTree.add(point: tapGesture.location(in: self), object: "hello")
        setNeedsDisplay()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if quadTree.bounds != bounds {
            let leaves = quadTree.leaves()
            quadTree = QuadTree(bounds: bounds, minimumSize: minimumSize)
            for leaf in leaves {
                quadTree.add(point: leaf.point, object: leaf.object)
            }
        }
    }

    private func drawRectangle(rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.addRect(rect)
        context.setLineWidth(1)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.strokePath()
    }

    private func drawCircle(centerPoint: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.beginPath()

        let radius = QuadTreeView.circleDiameter / 2
        let endAngle: CGFloat = CGFloat(2 * Double.pi)

        context.addArc(center: centerPoint, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)

        context.fillPath()
    }


    override func draw(_ rect: CGRect) {
        quadTree.traverse { (point, bounds) in
            if let centerPoint = point?.point {
                self.drawCircle(centerPoint: centerPoint)
            }
            self.drawRectangle(rect: bounds)
        }
    }
}
