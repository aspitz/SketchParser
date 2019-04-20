//
//  ArtboardView.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/23/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public class ArtboardView: UIView {
    let viewModel: ArtboardViewModel
    
    init(viewModel: ArtboardViewModel) {
        self.viewModel = viewModel
        super.init(frame: viewModel.frame)

        renderViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderViewModel() {
        viewModel.texts
            .map {
                let label = UILabel(frame: $0.frame.cgRect)
                label.attributedText = $0.attributedString.nsAttributedString
                return label
            }
            .forEach {
                addSubview($0)
            }
        
        viewModel.bitmaps
            .forEach {
                let imageView = UIImageView(frame: $0.frame.cgRect)
                
                addSubview(imageView)
                if let data = viewModel.imageData(named: $0.image.ref) {
                    let anImage = UIImage(data: data)
                    imageView.image = anImage
                }
            }
        
        viewModel.shapePathViewModels.map{ ShapePathView(viewModel: $0) }.forEach { addSubview($0) }
    }
}
