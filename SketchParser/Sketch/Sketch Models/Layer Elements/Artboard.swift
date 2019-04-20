//
//  Artboard.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/18/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public class Artboard: LayerElement {
    let layers: [LayerElement]
    
    enum CodingKeys: CodingKey {
        case layers
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        layers = try container.decode([LayerElement].self, ofFamily: LayerFamily.self, forKey: .layers)
        try super.init(from: decoder)
    }
    
    public func getAll<T>(_ type: T.Type) -> [T] {
        return layers.flatten(type)
    }
}
