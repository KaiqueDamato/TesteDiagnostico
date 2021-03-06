//
//  VS1View.swift
//  TesteDiagnostico
//
//  Created by Emannuel Fernandes de Oliveira Carvalho on 8/6/15.
//  Copyright (c) 2015 Kaique Damato. All rights reserved.
//

import UIKit

class VS1View: UIView {

    var points: [CGPoint]? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var patientPoints = [[CGPoint]()]
    
    override func drawRect(rect: CGRect) {
        if points != nil {
            if let count = points?.count {
                for i in Range(0..<count) {
                    if let point = points?[i] {
                        var circle = circleWithNumber(i + 1, atPoint: point)
                        circle.stroke()
                    }
                }
            }
        }
        for p in patientPoints {
            var path = UIBezierPath()
            for point in p {
                if point == p.first {
                    path.moveToPoint(point)
                } else {
                    path.addLineToPoint(point)
                }
            }
            path.stroke()
        }
    }
    
    func addPoint(point: CGPoint) {
        var pointsArray = patientPoints.removeLast()
        pointsArray.append(point)
        patientPoints.append(pointsArray)
    }
    
    func endStroke() {
        patientPoints.append([])
    }
    
    func circleWithNumber(number: Int, atPoint point: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.addArcWithCenter(point, radius: CGFloat(20), startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        return path
    }
}
