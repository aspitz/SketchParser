//
//  SketchFileModel.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/24/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

public struct SketchFileModel {
    public let archive: Archive
    public let document: SketchDocument

    public let title: String
    public let pageCount: Int
    
    public init?(resourceName: String) {
        guard let pathURL = Bundle.main.url(forResource: resourceName, withExtension: "sketch") else { return nil }
        self.init(pathURL: pathURL)
    }
    
    public init?(pathURL: URL) {
        let lastComponent = pathURL.lastPathComponent
        let titleSize = lastComponent.count - (pathURL.pathExtension.count + 1)
        title = String(lastComponent.prefix(titleSize))
        
        if let archive = Archive(url: pathURL, accessMode: .read),
            let documentData = archive.decompress(entryName: "document.json"),
            let document = try? JSONDecoder().decode(SketchDocument.self, from: documentData) {
            
            self.archive = archive
            self.document = document
            self.pageCount = document.pages.count
        } else {
            return nil
        }
    }
    
    public func page(number: Int) -> Page? {
        guard number < pageCount else { return nil }

        if let pageData = archive.decompress(entryName: document.pages[number].fileName),
            let page = try? JSONDecoder().decode(Page.self, from: pageData) {
            return page
        } else {
            return nil
        }
    }
    
    public func imageData(named imageName: String) -> Data? {
        return archive.decompress(entryName: imageName)
    }
    
    public func get(bitmap: Bitmap) -> UIImage? {
        if let data = archive.decompress(entryName: bitmap.image.ref) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
