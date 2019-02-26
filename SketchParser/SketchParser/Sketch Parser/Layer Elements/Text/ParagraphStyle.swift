//
//  ParagraphStyle.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct ParagraphStyle: Codable {
    let alignment: Int?
    
    private enum CodingKeys: CodingKey {
        case alignment
    }
    
    var nsParagraphStyle: NSParagraphStyle {
        let mutableParagraphStyle = NSMutableParagraphStyle()
        
        if let alignment = alignment {
            let textAlignment: NSTextAlignment
            switch alignment {
            case 0:
                textAlignment = .left
            case 1:
                textAlignment = .right
            case 2:
                textAlignment = .center
            case 3:
                textAlignment = .justified
            default:
                textAlignment = .natural
            }
            mutableParagraphStyle.alignment = textAlignment
        }
        
        return mutableParagraphStyle
    }
}
