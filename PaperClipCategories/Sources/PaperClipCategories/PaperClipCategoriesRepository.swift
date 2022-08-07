//
//  PaperClipCategoriesRepository.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation
import PaperClipCore
import PaperClipNetworkCore

protocol PaperClipCategoriesRepository {
    func get(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void)
}

final class PaperClipCategoriesRepositoryImpl {

    enum Endpoint: String {
        case get = "/categories.json"
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

// MARK: - PaperClipCategoriesRepository
extension PaperClipCategoriesRepositoryImpl: PaperClipCategoriesRepository {
    func get(completionHandler: @escaping (Result<[ClassifiedCategory], Error>) -> Void) {
        dependencies.api.get(path: Endpoint.get.rawValue) { result in
            if case let .failure(error) = result {
                completionHandler(.failure(error))
                return
            }
            do {
                let response = try result.get()
                let parsed = try JSONDecoder.defaultStrategy.decode([ClassifiedCategory].self, from: response)
                completionHandler(.success(parsed))
            } catch let error {
                completionHandler(.failure(error))
            }
        }
    }
}
