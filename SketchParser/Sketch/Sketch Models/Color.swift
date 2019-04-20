//
//  Color.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

struct Color: Decodable {
    let uiColor: UIColor
    
    private enum CodingKeys: CodingKey {
        case red
        case green
        case blue
        case alpha
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let red = try container.decode(Float.self, forKey: .red)
        let green = try container.decode(Float.self, forKey: .green)
        let blue = try container.decode(Float.self, forKey: .blue)
        let alpha = try container.decode(Float.self, forKey: .alpha)
        uiColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
    }
}
