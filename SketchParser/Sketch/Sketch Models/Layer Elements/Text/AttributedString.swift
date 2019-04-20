//
//  AttributedString.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct AttributedString: Decodable {
    let string: String
    let attributes: [StringAttribute]
    
    private enum CodingKeys: CodingKey {
        case string
        case attributes
    }

    var nsAttributedString: NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: string)
        
        attributes.forEach{ attribute in
            let attrs: [NSAttributedString.Key : Any] = [
                .font : attribute.attributes.fontAttribute?.uiFont,
                .foregroundColor : attribute.attributes.color?.uiColor,
                .paragraphStyle : attribute.attributes.paragraphStyle?.nsParagraphStyle,
                .kern : NSNumber(value: attribute.attributes.kerning ?? 0.0)
            ].filter { $0.value != nil }.mapValues { $0! }
            
            mutableAttributedString.addAttributes(attrs, range: attribute.range)
        }
        
        return mutableAttributedString
    }
}
