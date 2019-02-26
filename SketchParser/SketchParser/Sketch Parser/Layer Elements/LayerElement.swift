//
//  LayerElement.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public class LayerElement: Decodable {
    let frame: Rect
    
    private enum CodingKeys: CodingKey {
        case frame
    }
}
