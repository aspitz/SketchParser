//
//  Bitmap.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public class Bitmap: LayerElement {
    let image: Image
    
    private enum CodingKeys: CodingKey {
        case image
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.image = try container.decode(Image.self, forKey: .image)
        try super.init(from: decoder)
    }
}

struct Image: Codable {
    let ref: String

    private enum CodingKeys: String, CodingKey {
        case ref = "_ref"
    }
}
