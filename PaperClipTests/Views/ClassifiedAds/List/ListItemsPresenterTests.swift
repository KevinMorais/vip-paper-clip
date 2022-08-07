//
//  ListItemsPresenterTests.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
import PaperClipClassifiedAds
@testable import PaperClip

final class ListItemsPresenterTests: XCTestCase {
    
    private var viewControllerSpy: ListItemsViewControllerSpy!
    private var presenterUnderTesting: ListItemsPresenter!
    
    private enum FakeError: Error {
        case httpError
    }

    override func setUp() {
        super.setUp()
        viewControllerSpy = ListItemsViewControllerSpy()
        presenterUnderTesting = ListItemsPresenter(viewController: viewControllerSpy)
    }
    
    func test_ShouldDisplayLoading() {
        
        // Arrange
        let isLoading = true
        
        // Act
        presenterUnderTesting.present(loading: isLoading, items: [])
        
        // Assert
        let viewModel = viewControllerSpy.invokedDisplayParameters?.viewModel
        XCTAssertEqual(viewModel?.isActivityLoading, isLoading)
        XCTAssertEqual(viewModel?.cells.count, 0)
        XCTAssertEqual(viewModel?.title, "Classified Ads")
    }
    
    func test_ShouldDisplayItems() {
        
        // Arrange
        let isLoading = false
        let items = ClassifiedAd.stubArray
        
        // Act
        presenterUnderTesting.present(loading: isLoading, items: items)
        
        // Assert
        let viewModel = viewControllerSpy.invokedDisplayParameters?.viewModel
        XCTAssertEqual(viewModel?.isActivityLoading, isLoading)
        XCTAssertEqual(viewModel?.cells.count, 3)
        XCTAssertEqual(viewModel?.cells.first?.title, items.first?.title)
        XCTAssertEqual(viewModel?.cells.first?.imageURL, items.first?.images.small)
        XCTAssertEqual(viewModel?.cells.first?.priceText, items.first?.price.withCurrency())
        XCTAssertEqual(viewModel?.cells.first?.creationText, items.first?.creationDate.smallFormat())
        XCTAssertEqual(viewModel?.cells.first?.isImportant, items.first?.isUrgent)
        XCTAssertEqual(viewModel?.title, "Classified Ads")
    }
    
    func test_shouldDisplayDetail() {
        // Act
        presenterUnderTesting.presentDetail()
        
        // Assert
        XCTAssert(viewControllerSpy.invokedDisplayDetail)
    }
    
    func test_ShoudDisplayError() {
        
        // Arrange
        let error = FakeError.httpError
        
        // Act
        presenterUnderTesting.present(error: error)
        
        // Assert
        XCTAssertEqual(viewControllerSpy.invokedDisplayRetryHandlerParameters?.error as? FakeError, FakeError.httpError)
    }
    

}
