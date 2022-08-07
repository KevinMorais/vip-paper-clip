import Foundation

public enum APIClientError: Error, Equatable {
    case unknowned
    case emptyResponse
    case httpError(status: Int)

    public static func == (lhs: APIClientError, rhs: APIClientError) -> Bool {
        switch (lhs, rhs) {
        case (.unknowned, .unknowned):
            return true
        case (.emptyResponse, .emptyResponse):
            return true
        case (.httpError(let lhsStatus), (.httpError(let rhsStatus))):
            return lhsStatus == rhsStatus
        default:
            return false
        }
    }
}

public protocol APIClient {
    func get(path: String, completionHandler: @escaping (Result<Data, Error>) -> Void)
    func get(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

public class APIClientImpl {

    public struct Dependencies {
        let urlSession: URLSession
        let configuration: APIConfiguration

        init(urlSession: URLSession = .shared, configuration: APIConfiguration = .init()) {
            self.urlSession = urlSession
            self.configuration = configuration
        }
    }

    private let dependencies: Dependencies

    init(dependencies: Dependencies = .init()) {
        self.dependencies = dependencies
    }

    public init() {
        self.dependencies = Dependencies()
    }

    private func dataTask(with url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        dependencies.urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return
            }

            self.dependencies.configuration.responseQueue.async {
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }

                guard let response = (response as? HTTPURLResponse) else {
                    completionHandler(.failure(APIClientError.unknowned))
                    return
                }

                guard self.dependencies.configuration.rangeSuccessCode.contains(response.statusCode) else {
                    completionHandler(.failure(APIClientError.httpError(status: response.statusCode)))
                    return
                }

                guard let data = data, !data.isEmpty else {
                    completionHandler(.failure(APIClientError.emptyResponse))
                    return
                }
                completionHandler(.success(data))
            }
        }.resume()
    }

}

// MARK: - APIClient
extension APIClientImpl: APIClient {

    public func get(path: String, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        let url = dependencies.configuration.baseURL.appendingPathComponent(path)
        dataTask(with: url, completionHandler: completionHandler)
    }

    public func get(url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
        dataTask(with: url, completionHandler: completionHandler)
    }
}
