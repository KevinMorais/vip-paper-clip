//
//  ClassifiedCategory.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation

public struct ClassifiedCategory: Decodable {
    public let id: Int
    public let name: String

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
