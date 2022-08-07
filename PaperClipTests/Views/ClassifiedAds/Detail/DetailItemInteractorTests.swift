//
//  DetailItemInteractorTests.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
import PaperClipClassifiedAds
@testable import PaperClip

final class DetailItemInteractorTests: XCTestCase {
    private var presenterSpy: DetailItemPresenterSpy!
    private var interactorUnderTesting: DetailItemInteractor!

    override func setUp() {
        super.setUp()
        presenterSpy = .init()
        interactorUnderTesting = DetailItemInteractor(presenter: presenterSpy)
    }
    
    func test_loadContent_ShoudPresentItem() {
        // Arrange
        let item: ClassifiedAd = .stub
        interactorUnderTesting.item = item
        
        // Act
        interactorUnderTesting.loadContent()
        
        // Assert
        XCTAssertEqual(presenterSpy.invokedPresentParameters?.item.id, item.id)
    }
}
