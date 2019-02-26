//
//  SketchShapePathView.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/24/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

class SketchShapePathView: UIView {
    let viewModel: SketchShapePathViewModel
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: SketchShapePathViewModel) {
        self.viewModel = viewModel
        super.init(frame: viewModel.frame)
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        (viewModel.strokeColor ?? UIColor.clear).setStroke()
        viewModel.bezierPath.stroke()
        
        (viewModel.fillColor ?? UIColor.clear).setFill()
        viewModel.bezierPath.fill()
    }
}
