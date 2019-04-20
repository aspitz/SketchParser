//
//  StringAttribute.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

struct StringAttribute: Decodable {
    let range: NSRange
    let attributes: Attribute
    
    private enum CodingKeys: CodingKey {
        case location
        case length
        case attributes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let location = try container.decode(Int.self, forKey: .location)
        let length = try container.decode(Int.self, forKey: .length)
        range = NSRange(location: location, length: length)
        attributes = try container.decode(Attribute.self, forKey: .attributes)
    }
}
