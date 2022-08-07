//
//  PaperClipClassifiedAdsRepositoryTests.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import XCTest
@testable import PaperClipClassifiedAds
import PaperClipNetworkCore

final class PaperClipClassifiedAdsRepositoryTests: XCTestCase {

    private enum FakeError: Error {
        case httpFakeError
    }

    private var classifiedAdsRepoImpl: PaperClipClassifiedAdsRepositoryImpl!
    private var apiClientMock: APIClientMock!

    override func setUp() {
        super.setUp()
        apiClientMock = .init()
        classifiedAdsRepoImpl = .init(
            dependencies: .init(api: apiClientMock)
        )
    }

    func test_ShouldCallListing_Get() {

        // Arrange
        let expectedEndpoint = PaperClipClassifiedAdsRepositoryImpl.Endpoint.get.rawValue

        // Act
        classifiedAdsRepoImpl.get(completionHandler: { _ in })

        // Assert
        XCTAssertEqual(apiClientMock.invokedGetPathParameters?.path, expectedEndpoint)
    }

    func test_ShouldReturnErrorHTTP_Get() {

        // Arrange
        apiClientMock.stubbedGetPathCompletionHandlerResult = (.failure(FakeError.httpFakeError), ())
        let expectation = expectation(description: #function)

        // Act
        var response: Result<[ClassifiedAd], Error> = .success([])
        classifiedAdsRepoImpl.get { result in
            response = result
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            switch response {
            case .success:
                XCTFail(#function)
            case .failure(let error):
                XCTAssert(error is FakeError)
            }
        }
    }

    func test_ShouldReturnErrorDecodable_Get() {

        // Arrange
        let data = ClassifiedAd.getArrayWrongJSON().data(using: .utf8)!
        apiClientMock.stubbedGetPathCompletionHandlerResult = (.success(data), ())
        let expectation = expectation(description: #function)

        // Act
        var response: Result<[ClassifiedAd], Error> = .success([])
        classifiedAdsRepoImpl.get { result in
            response = result
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            switch response {
            case .success:
                XCTFail(#function)
            case .failure(let error):
                XCTAssert(error is DecodingError)
            }
        }

    }

    func test_ShouldReturnSuccess_Get() {

        // Arrange
        let data = ClassifiedAd.getArrayJSON().data(using: .utf8)!
        apiClientMock.stubbedGetPathCompletionHandlerResult = (.success(data), ())
        let expectation = expectation(description: #function)

        // Act
        var classifiedAds: [ClassifiedAd] = []
        classifiedAdsRepoImpl.get { result in
            classifiedAds = (try? result.get()) ?? []
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(classifiedAds.count, 2)
        }
    }
}
