//
//  Array.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

extension Array {
    public func flatten<T>(_ type: T.Type) -> [T] {
        return filter{ $0 is T }.map { $0 as! T }
    }
}
