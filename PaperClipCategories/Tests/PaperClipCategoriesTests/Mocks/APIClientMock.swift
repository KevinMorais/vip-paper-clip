//
//  File.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation
import PaperClipNetworkCore

final class APIClientMock: APIClient {

    var invokedGetPath = false
    var invokedGetPathCount = 0
    var invokedGetPathParameters: (path: String, Void)?
    var invokedGetPathParametersList = [(path: String, Void)]()
    var stubbedGetPathCompletionHandlerResult: (Result<Data, Error>, Void)?

    func get(path: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        invokedGetPath = true
        invokedGetPathCount += 1
        invokedGetPathParameters = (path, ())
        invokedGetPathParametersList.append((path, ()))
        if let result = stubbedGetPathCompletionHandlerResult {
            completionHandler(result.0)
        }
    }

    var invokedGetUrl = false
    var invokedGetUrlCount = 0
    var invokedGetUrlParameters: (url: URL, Void)?
    var invokedGetUrlParametersList = [(url: URL, Void)]()
    var stubbedGetUrlCompletionHandlerResult: (Result<Data, Error>, Void)?

    func get(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        invokedGetUrl = true
        invokedGetUrlCount += 1
        invokedGetUrlParameters = (url, ())
        invokedGetUrlParametersList.append((url, ()))
        if let result = stubbedGetUrlCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
