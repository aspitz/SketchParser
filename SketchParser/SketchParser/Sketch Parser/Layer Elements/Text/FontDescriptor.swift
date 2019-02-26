//
//  FontDescriptor.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct FontDescriptor: Decodable {
    let attributes: FontDescriptorAttributes
    
    private enum CodingKeys: CodingKey {
        case attributes
    }
    
    var uiFont: UIFont? {
        return attributes.uiFont
    }
}
