//
//  Document.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/9/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public struct Document: Decodable{
    let pages: [PageRef]
}
