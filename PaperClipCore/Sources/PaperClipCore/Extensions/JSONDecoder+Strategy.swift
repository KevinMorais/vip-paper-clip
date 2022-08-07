//
//  JSONDecoder+Strategy.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation

extension JSONDecoder {

    public static let defaultStrategy: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

}
