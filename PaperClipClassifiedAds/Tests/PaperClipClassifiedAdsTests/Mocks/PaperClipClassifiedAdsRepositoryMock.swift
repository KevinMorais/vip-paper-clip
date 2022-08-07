//
//  PaperClipClassifiedAdsRepositoryMock.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
@testable import PaperClipClassifiedAds

final class PaperClipClassifiedAdsRepositoryMock: PaperClipClassifiedAdsRepository {

    var invokedGet = false
    var invokedGetCount = 0
    var stubbedGetCompletionHandlerResult: (Result<[ClassifiedAd], Error>, Void)?

    func get(completionHandler: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        invokedGet = true
        invokedGetCount += 1
        if let result = stubbedGetCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
}
