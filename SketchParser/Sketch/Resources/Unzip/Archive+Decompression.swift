//
//  Archive+Decompression.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/17/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

extension Archive {
    func decompress(entryName: String) -> Data? {
        if let entry = self[entryName], let archiveFileHandle = try? FileHandle(forReadingFrom: self.url) {
            if let compressedData = archiveFileHandle.readData(fromOffset: UInt64(entry.dataOffset), length: entry.compressedSize), let data = compressedData.decompress(algorithm: entry.compressionAlgorithm, uncompressedSize: entry.uncompressedSize) {
                return data
            }
        }
        return nil
    }
}
