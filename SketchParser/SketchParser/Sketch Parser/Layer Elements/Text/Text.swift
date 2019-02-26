//
//  Text.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public class Text: LayerElement {
    let attributedString: AttributedString
    
    private enum CodingKeys: CodingKey {
        case attributedString
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributedString = try container.decode(AttributedString.self, forKey: .attributedString)
        try super.init(from: decoder)
    }
}
