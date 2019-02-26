//
//  ViewController.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/9/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var bookModel: SketchBookModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        bookModel = SketchBookModel(resourceName: "TestSketch")
        
        if let bookModel = bookModel {
            let pageModel = bookModel.page(number: 0)
            let pageViewModel = SketchPageViewModel(pageModel: pageModel)
            let pageView = SketchPageView(pageViewModel: pageViewModel)
            view.addSubview(pageView)
        }
    }
}
