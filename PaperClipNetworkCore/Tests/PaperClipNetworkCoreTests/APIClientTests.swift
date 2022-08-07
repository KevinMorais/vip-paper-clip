//
//  APIClientTests.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import XCTest
@testable import PaperClipNetworkCore

final class APIClientTests: XCTestCase {

    private var apiClient: APIClientImpl!

    override func setUp() {
        apiClient = .init(
            dependencies: .init(
                urlSession: .getMock(),
                configuration: .init()
            )
        )
    }

    func test_shouldReturn_EmptyResponseError() {

        // Arrange
        let testPath = "hello/SDSD"
        let expectation = expectation(description: #function)
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil)
        }

        // Act
        var response: Result<Data, Error> = .success(Data())
        apiClient.get(path: testPath) { (result: Result<Data, Error>) in
            response = result
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            if case let .failure(error) = response {
                XCTAssertEqual(error as? APIClientError, APIClientError.emptyResponse)
            } else {
                XCTFail(#function)
            }
        }
    }

    func test_shouldReturn_HTTPError() {

        // Arrange
        let testPath = "hello/SDSD"
        let expectedStatus = 400
        let expectation = expectation(description: #function)
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: expectedStatus, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        // Act
        var response: Result<Data, Error> = .success(Data())
        apiClient.get(path: testPath) { (result: Result<Data, Error>) in
            response = result
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            if case let .failure(error) = response {
                XCTAssertEqual(error as? APIClientError, APIClientError.httpError(status: expectedStatus))
            } else {
                XCTFail(#function)
            }
        }
    }

    func test_shouldReturn_Success() {

        // Arrange
        let testPath = "hello/SDSD"
        let expectedData = "{\"name\":\"Steve\"}".data(using: .utf8)
        let expectation = expectation(description: #function)
        URLProtocolMock.requestHandler = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, expectedData)
        }

        // Act
        var response: Result<Data, Error> = .success(Data())
        apiClient.get(path: testPath) { (result: Result<Data, Error>) in
            response = result
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            switch response {
            case .failure:
                XCTFail(#function)
            case .success(let data):
                XCTAssertEqual(data, expectedData)
            }
        }
    }

}
