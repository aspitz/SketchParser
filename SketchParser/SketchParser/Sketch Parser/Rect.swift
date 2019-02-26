//
//  Rect.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public struct Rect: Decodable {
    let cgRect: CGRect
    
    private enum CodingKeys: CodingKey {
        case height
        case width
        case x
        case y
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let height = try container.decode(Float.self, forKey: .height)
        let width = try container.decode(Float.self, forKey: .width)
        let x = try container.decode(Float.self, forKey: .x)
        let y = try container.decode(Float.self, forKey: .y)
        cgRect = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(width), height: CGFloat(height))
    }
}
