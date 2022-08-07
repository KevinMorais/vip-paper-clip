//
//  PaperClipCategoriesRepositoryTests.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import XCTest
@testable import PaperClipCategories

final class PaperClipCategoriesRepositoryTests: XCTestCase {

    private enum FakeError: Error {
        case httpFakeError
    }

    private var categoriesRepoImpl: PaperClipCategoriesRepositoryImpl!
    private var apiClientMock: APIClientMock!

    override func setUp() {
        super.setUp()
        apiClientMock = .init()
        categoriesRepoImpl = .init(
            dependencies: .init(api: apiClientMock)
        )
    }

    func test_ShouldCallEndpoint_Get() {

        // Arrange
        let expectedEndpoint = PaperClipCategoriesRepositoryImpl.Endpoint.get.rawValue

        // Act
        categoriesRepoImpl.get(completionHandler: { _ in })

        // Assert
        XCTAssertEqual(apiClientMock.invokedGetPathParameters?.path, expectedEndpoint)
    }

    func test_ShouldReturnErrorHTTP_Get() {

        // Arrange
        apiClientMock.stubbedGetPathCompletionHandlerResult = (.failure(FakeError.httpFakeError), ())
        let expectation = expectation(description: #function)

        // Act
        var response: Result<[ClassifiedCategory], Error> = .success([])
        categoriesRepoImpl.get { result in
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
        let data = ClassifiedCategory.getArrayWrongJSON().data(using: .utf8)!
        apiClientMock.stubbedGetPathCompletionHandlerResult = (.success(data), ())
        let expectation = expectation(description: #function)

        // Act
        var response: Result<[ClassifiedCategory], Error> = .success([])
        categoriesRepoImpl.get { result in
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
        let data = ClassifiedCategory.getArrayJSON().data(using: .utf8)!
        apiClientMock.stubbedGetPathCompletionHandlerResult = (.success(data), ())
        let expectation = expectation(description: #function)

        // Act
        var classifiedCategories: [ClassifiedCategory] = []
        categoriesRepoImpl.get { result in
            classifiedCategories = (try? result.get()) ?? []
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(classifiedCategories.count, 3)
        }
    }
}
