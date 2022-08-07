//
//  ListItemsInteractorTests.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
import PaperClipClassifiedAds
@testable import PaperClip

final class ListItemsInteractorTests: XCTestCase {
    private var presenterSpy: ListItemsPresenterSpyExpectation!
    private var interactorUnderTesting: ListItemsInteractor!
    private var classifiedFeatureMock: PaperClipClassifiedAdsMock!
    
    private enum FakeError: Error {
        case httpError
    }

    override func setUp() {
        super.setUp()
        presenterSpy = .init()
        classifiedFeatureMock = .init()
        interactorUnderTesting = ListItemsInteractor(
            presenter: presenterSpy,
            dependencies: .init(classifiedFeature: classifiedFeatureMock)
        )
    }
    
    func test_loadContent_ShouldCallPresenterLoading() {
        
        // Arrange
        let expectedLoading = true
        
        // Act
        interactorUnderTesting?.loadContent()
        
        // Assert
        XCTAssertEqual(presenterSpy.invokedPresentLoadingParameters?.loading, expectedLoading)
        XCTAssertEqual(presenterSpy.invokedPresentLoadingParameters?.items.count, 0)
    }
    
    func test_loadContent_ShouldFetchItems_Success() {
        
        // Arrange
        let stub = ClassifiedAd.stubArray
        presenterSpy.expectationNotLoading = expectation(description: #function)
        classifiedFeatureMock.stubbedFetchCompletionHandlerResult = (.success(stub), ())
        
        // Act
        interactorUnderTesting?.loadContent()
        
        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.loading, false)
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.items.count, 3)
        }
    }
    
    func test_loadContent_ShouldMakeUrgentFirst() {
        
        // Arrange
        let stub = ClassifiedAd.stubArray
        let expectedFirstItem = stub.first(where: { $0.isUrgent })
        presenterSpy.expectationNotLoading = expectation(description: #function)
        classifiedFeatureMock.stubbedFetchCompletionHandlerResult = (.success(stub), ())
        
        // Act
        interactorUnderTesting?.loadContent()
        
        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.loading, false)
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.items.count, 3)
            XCTAssertFalse(self.presenterSpy.invokedPresent)
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.items.first?.id, expectedFirstItem?.id)
        }
    }
    
    func test_loadContent_ShouldFetchItems_Failure() {
        // Arrange
        presenterSpy.expectationNotLoading = expectation(description: #function)
        classifiedFeatureMock.stubbedFetchCompletionHandlerResult = (.failure(FakeError.httpError), ())
        
        // Act
        interactorUnderTesting?.loadContent()
        
        // Assert
        waitForExpectations(timeout: 2) { _ in
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.loading, false)
            XCTAssertEqual(self.presenterSpy.invokedPresentLoadingParametersList.last?.items.count, 0)
            XCTAssertEqual(self.presenterSpy.invokedPresentParameters?.error as? FakeError, FakeError.httpError)
        }
    }
    
    func test_userDidSelectItem_ShouldCallPresenterDetail() {
        
        // Arrange
        let stub = ClassifiedAd.stubArray
        presenterSpy.expectationNotLoading = expectation(description: #function)
        classifiedFeatureMock.stubbedFetchCompletionHandlerResult = (.success(stub), ())
        interactorUnderTesting?.loadContent()
        
        // Act
        waitForExpectations(timeout: 2) { _ in
            self.interactorUnderTesting?.userDidSelectItem(at: 1)
        }
        
        // Assert
        XCTAssert(presenterSpy.invokedPresentDetail)
        XCTAssertEqual(interactorUnderTesting.selectedItem.id, stub[0].id) // Get at index 0 because the interactor reorder elements by isUrgent
    }
}
