//
//  LayerElement.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public class LayerElement: Decodable {
    let frame: Rect
    
    public var rect: CGRect { return frame.cgRect }
    public var size: CGSize { return frame.cgRect.size }
    
    private enum CodingKeys: CodingKey {
        case frame
    }
}
