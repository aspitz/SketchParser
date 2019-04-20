//
//  ArtboardViewModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/23/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

class ArtboardViewModel {
    let model: ArtboardModel
    
    let frame: CGRect
    
    public let texts: [Text]
    public let bitmaps: [Bitmap]
    public let shapePathViewModels: [ShapePathViewModel]
    
    init(model: ArtboardModel) {
        self.model = model
        
        var frame = model.frame.cgRect
        frame.origin = CGPoint.zero
        self.frame = frame
        
        texts = model.texts
        bitmaps = model.bitmaps
        shapePathViewModels = model.shapePaths.map { ShapePathViewModel(model: $0) }
    }
    
    public func imageData(named imageName: String) -> Data? {
        return model.imageData(named: imageName)
    }
}
