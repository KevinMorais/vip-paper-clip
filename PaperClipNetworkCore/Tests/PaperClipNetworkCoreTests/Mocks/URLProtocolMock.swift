//
//  URLProtocolMock.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation

final class URLProtocolMock: URLProtocol {

    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = Self.requestHandler else {
            fatalError("Handler is unavailable.")
        }
        do {
            let (response, data) = try handler(request)

            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}

}
