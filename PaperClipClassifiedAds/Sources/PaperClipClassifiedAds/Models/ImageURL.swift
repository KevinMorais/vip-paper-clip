//
//  ImageURL.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation

public struct ImageURL: Decodable {
    public let small: URL?
    public let thumb: URL?

    public init(small: URL?, thumb: URL?) {
        self.small = small
        self.thumb = thumb
    }
}
