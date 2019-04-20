//
//  ShapePath.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/12/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public class ShapePath: LayerElement {
    let points: [CurvePoint]
    let isClosed: Bool
    let style: Style
    
    private enum CodingKeys: CodingKey {
        case points
        case isClosed
        case style
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.points = try container.decode([CurvePoint].self, forKey: .points)
        self.isClosed = try container.decode(Bool.self, forKey: .isClosed)
        self.style = try container.decode(Style.self, forKey: .style)
        try super.init(from: decoder)
    }
}
