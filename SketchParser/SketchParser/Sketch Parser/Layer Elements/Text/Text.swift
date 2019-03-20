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
    let textBehaviour: Int
    
    private enum CodingKeys: CodingKey {
        case attributedString
        case textBehaviour
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.attributedString = try container.decode(AttributedString.self, forKey: .attributedString)
        self.textBehaviour = try container.decode(Int.self, forKey: .textBehaviour)
        try super.init(from: decoder)
    }
    
    public var nsAttributedString: NSAttributedString {
        return attributedString.nsAttributedString
    }
    
    public var autoHeight: Bool {
        return (textBehaviour == 0)
    }
}
