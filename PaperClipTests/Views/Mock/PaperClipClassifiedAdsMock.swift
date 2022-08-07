//
//  PaperClipClassifiedAdsMock.swift
//  PaperClipTests
//
//  Created by Kevin Morais on 06/08/2022.
//

import XCTest
import PaperClipClassifiedAds

final class PaperClipClassifiedAdsMock: PaperClipClassifiedAds {

    var invokedFetch = false
    var invokedFetchCount = 0
    var stubbedFetchCompletionHandlerResult: (Result<[ClassifiedAd], Error>, Void)?

    func fetch(completionHandler: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        invokedFetch = true
        invokedFetchCount += 1
        if let result = stubbedFetchCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
