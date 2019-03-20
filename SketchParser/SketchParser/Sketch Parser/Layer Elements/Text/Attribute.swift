//
//  Attribute.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

struct Attribute: Decodable {
    let fontAttribute: FontDescriptor?
    let color: Color?
    let paragraphStyle: ParagraphStyle?
    let kerning: Float?
    
    private enum CodingKeys: String, CodingKey {
        case fontAttribute = "MSAttributedStringFontAttribute"
        case color = "MSAttributedStringColorAttribute"
        case paragraphStyle
        case kerning
    }
}
