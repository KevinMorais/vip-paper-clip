//
//  PaperClipClassifiedAdsRepository.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
import PaperClipCore
import PaperClipNetworkCore

protocol PaperClipClassifiedAdsRepository {
    func get(completionHandler: @escaping (Result<[ClassifiedAd], Error>) -> Void)
}

final class PaperClipClassifiedAdsRepositoryImpl {

    enum Endpoint: String {
        case get = "/listing.json"
    }

    struct Dependencies {
        let api: APIClient
        init(api: APIClient = APIClientImpl()) {
            self.api = api
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }

}

// MARK: - PaperClipClassifiedAdsRepository
extension PaperClipClassifiedAdsRepositoryImpl: PaperClipClassifiedAdsRepository {

    public func get(completionHandler: @escaping (Result<[ClassifiedAd], Error>) -> Void) {
        dependencies.api.get(path: Endpoint.get.rawValue) { result in
            if case let .failure(error) = result {
                completionHandler(.failure(error))
                return
            }
            do {
                let response = try result.get()
                let parsed = try JSONDecoder.defaultStrategy.decode([ClassifiedAd].self, from: response)
                completionHandler(.success(parsed))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }
}
