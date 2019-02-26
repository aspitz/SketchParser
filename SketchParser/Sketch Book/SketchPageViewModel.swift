//
//  SketchPageViewModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/23/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

class SketchPageViewModel {
    let pageModel: SketchPageModel
    
    let frame: CGRect
    
    public let texts: [Text]
    public let bitmaps: [Bitmap]
    public let shapePathViewModels: [SketchShapePathViewModel]
    
    init(pageModel: SketchPageModel) {
        self.pageModel = pageModel
        
        var frame = pageModel.frame.cgRect
        frame.origin = CGPoint.zero
        self.frame = frame
        
        texts = pageModel.texts
        bitmaps = pageModel.bitmaps
        shapePathViewModels = pageModel.shapePaths.map { SketchShapePathViewModel(model: $0) }
    }
    
    public func imageData(named imageName: String) -> Data? {
        return pageModel.imageData(named: imageName)
    }
}
