//
//  File.swift
//  
//
//  Created by Kevin Morais on 07/08/2022.
//

import Foundation
import PaperClipCategories

class PaperClipCategoriesMock: PaperClipCategories {

    var invokedFetch = false
    var invokedFetchCount = 0
    var stubbedFetchCompletionHandlerResult: (Result<[ClassifiedCategory], Error>, Void)?

    func fetch(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void) {
        invokedFetch = true
        invokedFetchCount += 1
        if let result = stubbedFetchCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
