//
//  SketchDocumentModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

public struct SketchDocumentModel {
    private let sketchFile: FileModel
    private let sketchArtboards: [Artboard]
    
    public init?(resourceName: String) {
        self.init(sketchFile: FileModel(resourceName: resourceName))
    }
    
    public init?(pathURL: URL) {
        self.init(sketchFile: FileModel(pathURL: pathURL))
    }
    
    private init?(sketchFile: FileModel?) {
        guard let sketchFile = sketchFile else { return nil }
        
        self.sketchFile = sketchFile
        if let page = sketchFile.page(number: 0) {
            sketchArtboards = page.filteredLayers(Artboard.self)
        } else {
            return nil
        }
    }
    
    
    public var artboardCount: Int {
        return sketchArtboards.count
    }

    public func artboard(index: Int) -> ArtboardModel {
        let artboard = sketchArtboards[index]
        return ArtboardModel(artboardIndex: index, artboard: artboard, from: self)
    }
    
    func imageData(named imageName: String) -> Data? {
        return sketchFile.imageData(named: imageName)
    }
}
