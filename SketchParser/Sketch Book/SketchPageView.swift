//
//  SketchPageView.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/23/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public class SketchPageView: UIView {
    let pageViewModel: SketchPageViewModel
    
    init(pageViewModel: SketchPageViewModel) {
        self.pageViewModel = pageViewModel
        super.init(frame: pageViewModel.frame)

        renderPageViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func renderPageViewModel() {
        pageViewModel.texts
            .map {
                let label = UILabel(frame: $0.frame.cgRect)
                label.attributedText = $0.attributedString.nsAttributedString
                return label
            }
            .forEach {
                addSubview($0)
            }
        
        pageViewModel.bitmaps
            .forEach {
                let imageView = UIImageView(frame: $0.frame.cgRect)
                
                addSubview(imageView)
                if let data = pageViewModel.imageData(named: $0.image.ref) {
                    let anImage = UIImage(data: data)
                    imageView.image = anImage
                }
            }
        
        pageViewModel.shapePathViewModels.map{ SketchShapePathView(viewModel: $0) }.forEach { addSubview($0) }
    }
}
