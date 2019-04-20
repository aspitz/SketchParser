//
//  StyleElement.swift
//  SketchParser
//
//  Created by Ayal Spitz on 4/20/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

struct StyleElement: Decodable {
    let color: Color
    let isEnabled: Bool
}
