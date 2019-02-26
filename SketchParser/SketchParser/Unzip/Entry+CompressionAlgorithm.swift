//
//  Entry+CompressionAlgorithm.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/17/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

extension Entry {
    var compressionAlgorithm: Compression.Algorithm {
        var algorithm: Compression.Algorithm = .none
        if centralDirectoryStructure.compressionMethod == CompressionMethod.deflate.rawValue {
            algorithm = .zlib
        }
        
        return algorithm
    }
}
