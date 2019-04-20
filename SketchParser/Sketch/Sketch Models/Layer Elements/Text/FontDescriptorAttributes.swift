//
//  FontDescriptorAttributes.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct FontDescriptorAttributes: Decodable {
    let uiFont: UIFont
    
    private enum CodingKeys: CodingKey {
        case name
        case size
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let size = try container.decode(Float.self, forKey: .size)
        
        if name.starts(with: "SFUIDisplay") || name.starts(with: "SFUIText") {
            let components = name.components(separatedBy: "-")
            let weightString = components[1].lowercased()
            let weight = UIFont.Weight.weight(from: weightString)
            uiFont = UIFont.systemFont(ofSize: CGFloat(size), weight: weight)
        } else {
            if let font = UIFont(name: name, size: CGFloat(size)) {
                uiFont = font
            } else {
                uiFont = UIFont.systemFont(ofSize: CGFloat(size))
            }
        }
    }
}
