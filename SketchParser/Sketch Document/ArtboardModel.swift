//
//  ArtboardModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public struct ArtboardModel {
    private let documentModel: SketchDocumentModel
    private let index: Int
    private let sketchArtboard: Artboard

    public let frame: Rect
    public let texts: [Text]
    public let bitmaps: [Bitmap]
    public let shapePaths: [ShapePath]
    
    init(artboardIndex: Int, artboard: Artboard, from documentModel: SketchDocumentModel) {
        self.documentModel = documentModel
        index = artboardIndex
        sketchArtboard = artboard
        
        frame = sketchArtboard.frame
        
        texts = sketchArtboard.layers.flatten(Text.self)
        bitmaps = sketchArtboard.layers.flatten(Bitmap.self)
        shapePaths = sketchArtboard.layers.flatten(ShapePath.self)
    }

    public func imageData(named imageName: String) -> Data? {
        return documentModel.imageData(named: imageName)
    }
}
