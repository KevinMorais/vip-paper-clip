//
//  PaperClipCategoriesRepositoryMock.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation
@testable import PaperClipCategories

final class PaperClipCategoriesRepositoryMock: PaperClipCategoriesRepository {

    var invokedGet = false
    var invokedGetCount = 0
    var stubbedGetCompletionHandlerResult: (Result<[ClassifiedCategory], Error>, Void)?

    func get(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void) {
        invokedGet = true
        invokedGetCount += 1
        if let result = stubbedGetCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
