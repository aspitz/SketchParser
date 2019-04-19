//
//  SketchPageModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public struct SketchPageModel {
    private let bookModel: SketchDocumentModel
    private let number: Int
    private let sketchArtboard: Artboard

    public let frame: Rect
    public let texts: [Text]
    public let bitmaps: [Bitmap]
    public let shapePaths: [ShapePath]
    
    init(pageNumber: Int, artboard: Artboard, from bookModel: SketchDocumentModel) {
        self.bookModel = bookModel
        number = pageNumber
        sketchArtboard = artboard
        
        frame = sketchArtboard.frame
        
        texts = sketchArtboard.layers.flatten(Text.self)
        bitmaps = sketchArtboard.layers.flatten(Bitmap.self)
        shapePaths = sketchArtboard.layers.flatten(ShapePath.self)
    }

    public func imageData(named imageName: String) -> Data? {
        return bookModel.imageData(named: imageName)
    }
}
