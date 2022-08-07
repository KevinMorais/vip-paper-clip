//
//  URLSessionMock.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation

extension URLSession {

    static func getMock() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configuration)
    }
}
