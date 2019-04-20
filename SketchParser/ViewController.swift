//
//  ViewController.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/9/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var documentModel: SketchDocumentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        documentModel = SketchDocumentModel(resourceName: "TestSketch")
        
        if let documentModel = documentModel {
            let artboardModel = documentModel.artboard(index: 0)
            let artboardViewModel = ArtboardViewModel(model: artboardModel)
            let artboardView = ArtboardView(viewModel: artboardViewModel)
            view.addSubview(artboardView)
        }
    }
}
