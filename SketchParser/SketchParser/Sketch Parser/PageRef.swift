//
//  PageRef.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/24/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

struct PageRef: Decodable {
    let fileName: String
    
    enum CodingKeys: String, CodingKey {
        case ref = "_ref"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let ref = try container.decode(String.self, forKey: .ref)
        fileName = ref + ".json"
    }
}
