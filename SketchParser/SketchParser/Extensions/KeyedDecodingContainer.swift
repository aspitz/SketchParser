//
//  KeyedDecodingContainer.swift
//  SketchParser
//
//  Created by Ayal Spitz on 2/10/19.
//  Copyright © 2019 Ayal Spitz. All rights reserved.
//

import Foundation

protocol ClassFamily: Decodable {
    associatedtype Discriminator: CodingKey
    static var discriminator: Discriminator { get }
    
    func getType() -> AnyObject.Type
}

extension KeyedDecodingContainer {
    func decode<T : Decodable, U : ClassFamily>(_ heterogeneousType: [T].Type, ofFamily family: U.Type, forKey key: K) throws -> [T] {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        var list = [T]()
        var tmpContainer = container
        while !container.isAtEnd {
            do {
                let typeContainer = try container.nestedContainer(keyedBy: U.Discriminator.self)
                let family: U = try typeContainer.decode(U.self, forKey: U.discriminator)
                if let type = family.getType() as? T.Type {
                    list.append(try tmpContainer.decode(type))
                }
            } catch let error {
                print(error)
            }
        }
        return list
    }
}
