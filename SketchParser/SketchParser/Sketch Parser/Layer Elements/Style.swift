//
//  Style.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/23/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

struct Style: Decodable {
    let borders: [StyleElement]?
    let fills: [StyleElement]?
}

struct StyleElement: Decodable {
    let color: Color
    let isEnabled: Bool
}
