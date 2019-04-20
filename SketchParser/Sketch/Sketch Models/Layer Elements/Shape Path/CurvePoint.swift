//
//  CurvePoint.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct CurvePoint: Decodable {
    let curveFrom: String
    let curveTo: String
    let hasCurveFrom: Bool
    let hasCurveTo: Bool
    let point: String
    
    private enum CodingKeys: CodingKey {
        case curveFrom
        case curveTo
        case hasCurveFrom
        case hasCurveTo
        case point
    }
    
    static func toPoint(_ point: String) -> CGPoint {
        return NSCoder.cgPoint(for: point)
    }
}
