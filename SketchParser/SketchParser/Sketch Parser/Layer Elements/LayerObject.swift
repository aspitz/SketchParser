//
//  LayerObject.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

enum LayerObject: String, ClassFamily {
    case text = "text"
    case artboard = "artboard"
    case slice = "slice"
    case bitmap = "bitmap"
    
    // ShapePath
    case shapePath = "shapePath"
    case oval = "oval"
    case star = "star"
    case rectangle = "rectangle"
    case triangle = "triangle"
    case polygon = "polygon"

    enum Discriminator: String, CodingKey {
        case clazz = "_class"
    }
    
    static var discriminator: Discriminator = .clazz
    
    func getType() -> AnyObject.Type {
        switch self {
        case .artboard:
            return Artboard.self
        case .text:
            return Text.self
        case .slice:
            return Slice.self
        case .bitmap:
            return Bitmap.self

        case .shapePath, .oval, .star, .rectangle, .triangle, .polygon:
            return ShapePath.self
        }
    }
}
