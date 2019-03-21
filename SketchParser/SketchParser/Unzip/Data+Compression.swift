//
//  Data+Compression.swift
//  BookFormat
//
//  Created by Ayal Spitz on 7/15/18.
//  Copyright © 2018 Ayal Spitz. All rights reserved.
//

import Foundation
import Compression

struct Compression {
    enum Algorithm: String, Codable {
        case none
        case lzfse
        case lz4
        case lzma
        case zlib
        
        var compression_algorithm: compression_algorithm? {
            switch self {
            case .none:
                return nil
            case .lzfse:
                return COMPRESSION_LZFSE
            case .lz4:
                return COMPRESSION_LZ4
            case .lzma:
                return COMPRESSION_LZMA
            case .zlib:
                return COMPRESSION_ZLIB
            }
        }
    }

    enum Transform {
        case encode
        case decode
        
        var function: (UnsafeMutablePointer<UInt8>, Int, UnsafePointer<UInt8>, Int, UnsafeMutableRawPointer?, compression_algorithm) -> Int {
            switch self {
            case .encode:
                return compression_encode_buffer
            case .decode:
                return compression_decode_buffer
            }
        }
    }
}

extension Data {
    func compress(algorithm: Compression.Algorithm = .lzfse) -> Data? {
        return transform(algorithm: algorithm, transform: .encode)
    }
    
    func decompress(algorithm: Compression.Algorithm = .lzfse, uncompressedSize: Int) -> Data? {
        return transform(algorithm: algorithm, transform: .decode, dstSize: uncompressedSize)
    }

    private func transform(algorithm: Compression.Algorithm = .lzfse, transform: Compression.Transform, dstSize: Int? = nil) -> Data? {
        guard algorithm != .none else { return Data(self) }
        
        let compressionAlgorithm = algorithm.compression_algorithm!
        let fromSize = count
        let toSize = dstSize ?? count
        var toData = Data(count: toSize)
        var bytesWriten = 0

        withUnsafeBytes{ (fromBytes) -> Void in
            toData.withUnsafeMutableBytes{ (toBytes) -> Void in
                bytesWriten = transform.function(toBytes, toSize, fromBytes, fromSize, nil, compressionAlgorithm)
            }
        }
        
        if bytesWriten == 0 {
            return nil
        } else {
            let delta = toData.count - bytesWriten
            if  delta > 0 {
                toData.removeLast(delta)
            }
            return toData
        }
    }
}
