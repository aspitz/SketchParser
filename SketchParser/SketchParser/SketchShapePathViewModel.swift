//
//  SketchShapePathViewModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/24/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct SketchShapePathViewModel {
    let frame: CGRect
    let bezierPath: UIBezierPath
    let strokeColor: UIColor?
    let fillColor: UIColor?
    
    init(model: ShapePath) {
        let offset: CGFloat = 2.0
        frame = model.frame.cgRect.insetBy(dx: -offset, dy: -offset)
        bezierPath = UIBezierPath()
        strokeColor = model.style.borders?.filter{ $0.isEnabled }.first?.color.uiColor
        fillColor = model.style.fills?.filter{ $0.isEnabled }.first?.color.uiColor

        let size = model.frame.cgRect.size
        var points = model.points
        if model.isClosed { points.append(points[0]) }
        
        let pointViewModels = points.map { SketchCurvePointViewModel(curvePoint: $0, size: size, offset: offset) }
        
        for index in 0..<points.count {
            let currentPt = pointViewModels[index]
            
            if index == 0 {
                bezierPath.move(to: currentPt.point)
            } else {
                let previousPt = pointViewModels[index - 1]
                if let curveFrom = previousPt.curveFrom, let curveTo = currentPt.curveTo {
                    bezierPath.addCurve(to: currentPt.point, controlPoint1: curveFrom, controlPoint2: curveTo)
                } else if let curveTo = currentPt.curveTo {
                    bezierPath.addQuadCurve(to: currentPt.point, controlPoint: curveTo)
                } else if let curveFrom = previousPt.curveFrom {
                    bezierPath.addQuadCurve(to: currentPt.point, controlPoint: curveFrom)
                } else {
                    bezierPath.addLine(to: currentPt.point)
                }
            }
        }
    }
}
