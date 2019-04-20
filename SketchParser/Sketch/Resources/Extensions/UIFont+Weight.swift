//
//  UIFont+Weight.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/22/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import UIKit

extension UIFont.Weight {
    static func weight(from weightName: String) -> UIFont.Weight {
        let weight: UIFont.Weight
        
        switch weightName {
        case "black":
            weight = .black
        case "bold":
            weight = .bold
        case "heavy":
            weight = .heavy
        case "light":
            weight = .light
        case "medium":
            weight = .medium
        case "regular":
            weight = .regular
        case "semibold":
            weight = .semibold
        case "thin":
            weight = .thin
        case "ultralight":
            weight = .ultraLight
        default:
            weight = .regular
        }
        
        return weight
    }
}
