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
    
    private struct Constants {
        static let circleDiameter: CGFloat = 4
        static let minimumSubQuadSize = CGSize(width: circleDiameter, height: circleDiameter)
    }
    
    private let instructionsLabel = UILabel(frame: CGRect())
    private var quadTree: QuadTree<String>!

    override func awakeFromNib() {
        super.awakeFromNib()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didRecognized(tapGesture:)))
        addGestureRecognizer(tapGesture)
        
        setupInstructionsLabel()
    }

    private func setupInstructionsLabel() {
        addSubview(instructionsLabel)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionsLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        instructionsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        instructionsLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        instructionsLabel.text = "Tap somewhere to add a point"
        instructionsLabel.textAlignment = .center
        instructionsLabel.backgroundColor = UIColor(red: 94 / 255, green: 94 / 255, blue: 94 / 255, alpha: 1)
        instructionsLabel.textColor = .white
    }
    
    @objc func didRecognized(tapGesture: UITapGestureRecognizer) {
        instructionsLabel.isHidden = true
        quadTree.add(point: tapGesture.location(in: self), object: "hello")
        setNeedsDisplay()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if quadTree?.bounds != bounds {
            rebuildQuadTree()
            
            setNeedsDisplay()
        }
    }
    
    private func rebuildQuadTree() {
        let leaves = quadTree?.leaves() ?? []
        quadTree = QuadTree(bounds: bounds, minimumSubQuadSize: Constants.minimumSubQuadSize)
        for leaf in leaves {
            quadTree.add(point: leaf.point, object: leaf.object)
        }
    }

    private func drawRectangle(rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        context.addRect(rect)
        context.setLineWidth(1)
        context.setStrokeColor(UIColor.blue.cgColor)
        context.strokePath()
    }

    private func drawCircle(centerPoint: CGPoint) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.beginPath()

        let radius = Constants.circleDiameter / 2
        let endAngle: CGFloat = CGFloat(2 * Double.pi)

        context.addArc(center: centerPoint, radius: radius, startAngle: 0, endAngle: endAngle, clockwise: true)

        context.fillPath()
    }

    override func draw(_ rect: CGRect) {
        quadTree.traverseLeaves { (leaf, containedInBounds) in
            if let centerPoint = leaf?.point {
                self.drawCircle(centerPoint: centerPoint)
            }
            self.drawRectangle(rect: containedInBounds)
        }
    }
}
