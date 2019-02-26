//
//  Page.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public struct Page: Decodable {
    let layers: [LayerElement]

    enum CodingKeys: CodingKey {
        case layers
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        layers = try container.decode([LayerElement].self, ofFamily: LayerObject.self, forKey: .layers)
    }
    
    public func filteredLayers <T>(_ type: T.Type) -> [T] {
        return layers.flatten(type)
    }
}
