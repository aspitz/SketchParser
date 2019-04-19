//
//  SketchDocumentModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public struct SketchDocumentModel {
    private let sketchFile: SketchFileModel
    private let sketchArtboards: [Artboard]
    
    public init?(resourceName: String) {
        self.init(sketchFile: SketchFileModel(resourceName: resourceName))
    }
    
    public init?(pathURL: URL) {
        self.init(sketchFile: SketchFileModel(pathURL: pathURL))
    }
    
    private init?(sketchFile: SketchFileModel?) {
        guard let sketchFile = sketchFile else { return nil }
        
        self.sketchFile = sketchFile
        if let page = sketchFile.page(number: 0) {
            sketchArtboards = page.filteredLayers(Artboard.self)
        } else {
            return nil
        }
    }
    
    
    public var pageCount: Int {
        return sketchArtboards.count
    }

    public func page(number: Int) -> SketchPageModel {
        let artboard = sketchArtboards[number]
        return SketchPageModel(pageNumber: number, artboard: artboard, from: self)
    }
    
    func imageData(named imageName: String) -> Data? {
        return sketchFile.imageData(named: imageName)
    }
}
