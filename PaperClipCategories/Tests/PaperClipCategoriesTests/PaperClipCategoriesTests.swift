import XCTest
@testable import PaperClipCategories

final class PaperClipCategoriesTests: XCTestCase {

    private var categoriesImpl: PaperClipCategoriesImpl!
    private var repositoryMock: PaperClipCategoriesRepositoryMock!

    override func setUp() {
        super.setUp()
        repositoryMock = .init()
        categoriesImpl = .init(
            dependencies: .init(repository: repositoryMock)
        )
    }

    func test_ShouldCallRepo_fetch() {
        // Arrange
        let expectation = expectation(description: #function)
        repositoryMock.stubbedGetCompletionHandlerResult = (.success([]), ())

        // Act
        categoriesImpl.fetch(completionHandler: { _ in
            expectation.fulfill()
        })

        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(self.repositoryMock.invokedGetCount, 1)
        }

    }
}
