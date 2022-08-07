import XCTest
import PaperClipCategories
@testable import PaperClipClassifiedAds

final class PaperClipClassifiedAdsTests: XCTestCase {

    private var classifiedAdsImpl: PaperClipClassifiedAdsImpl!
    private var repositoryMock: PaperClipClassifiedAdsRepositoryMock!
    private var categoriesFeatureMock: PaperClipCategoriesMock!

    override func setUp() {
        super.setUp()
        repositoryMock = .init()
        categoriesFeatureMock = .init()
        classifiedAdsImpl = .init(
            dependencies: .init(
                repository: repositoryMock,
                categoriesFeature: categoriesFeatureMock
            )
        )
    }

    func test_ShouldCallRepo_fetch() {

        // Arrange
        let expectation = expectation(description: #function)
        categoriesFeatureMock.stubbedFetchCompletionHandlerResult = (.success([]), ())
        repositoryMock.stubbedGetCompletionHandlerResult = (.success([]), ())

        // Act
        classifiedAdsImpl.fetch { _ in
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(self.repositoryMock.invokedGetCount, 1)
        }
    }

    func test_ShouldAppendCategories() {
        
        // Arrange
        let expectation = expectation(description: #function)
        let categories = ClassifiedCategory.stubArray
        let classifiedAds = ClassifiedAd.stubArray
        categoriesFeatureMock.stubbedFetchCompletionHandlerResult = (.success(categories), ())
        repositoryMock.stubbedGetCompletionHandlerResult = (.success(classifiedAds), ())

        // Act
        var classifiedAdsResponse: [ClassifiedAd] = []
        classifiedAdsImpl.fetch { result in
            classifiedAdsResponse = (try? result.get()) ?? []
            expectation.fulfill()
        }

        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(self.repositoryMock.invokedGetCount, 1)
            let filterClassifiedAds = classifiedAdsResponse.filter { $0.category != nil }
            XCTAssertEqual(filterClassifiedAds.count, 2)
        }
    }
}
