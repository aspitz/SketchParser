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
        let pattern = #"[0-9]+\.?[0-9]*"#
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(point.startIndex..<point.endIndex, in: point)
            let matches = regex.matches(in: point, range: range)
            let foo: [Double] = matches.map {
                let range = Range($0.range, in: point)
                return Double( point[range!] )!
            }
            return CGPoint(x: foo[0], y: foo[1])
        } catch let error {
            print(error)
        }
        return CGPoint.zero
    }
}
