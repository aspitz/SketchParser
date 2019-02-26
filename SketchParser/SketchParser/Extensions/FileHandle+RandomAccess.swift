//
//  FileHandle+RandomAccess.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/17/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

extension FileHandle {
    func readData(fromOffset offset: UInt64, length: Int) -> Data? {
        seek(toFileOffset:offset)
        return readData(ofLength: length)
    }
}
