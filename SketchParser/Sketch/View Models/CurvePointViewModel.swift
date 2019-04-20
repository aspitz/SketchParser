//
//  CurvePointViewModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/24/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct CurvePointViewModel {
    let point: CGPoint
    let curveFrom: CGPoint?
    let curveTo: CGPoint?
    
    init(curvePoint: CurvePoint, size: CGSize, offset: CGFloat) {
        point = CurvePointViewModel.convert(pt: curvePoint.point, size: size, offset: offset)
        if curvePoint.hasCurveFrom {
            curveFrom = CurvePointViewModel.convert(pt: curvePoint.curveFrom, size: size, offset: offset)
        } else {
            curveFrom = nil
        }
        
        if curvePoint.hasCurveTo {
            curveTo = CurvePointViewModel.convert(pt: curvePoint.curveTo, size: size, offset: offset)
        } else {
            curveTo = nil
        }
    }
    
    private static func convert(pt: String, size: CGSize, offset: CGFloat) -> CGPoint {
        let d = CurvePoint.toPoint(pt)
        let pt = CGPoint(x: size.width * d.x, y: size.height * d.y).applying(CGAffineTransform(translationX: offset, y: offset))
        
        return pt
    }
}
