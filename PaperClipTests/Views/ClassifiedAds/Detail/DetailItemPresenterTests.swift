//
//  DetailItemPresenterTests.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
import PaperClipClassifiedAds
@testable import PaperClip

final class DetailItemPresenterTests: XCTestCase {
    private var viewControllerSpy: DetailItemViewControllerSpy!
    private var presenterUnderTesting: DetailItemPresenter!

    override func setUp() {
        super.setUp()
        viewControllerSpy = DetailItemViewControllerSpy()
        presenterUnderTesting = DetailItemPresenter(viewController: viewControllerSpy)
    }
    
    func test_PresentItem_ShouldHaveViewModel() {
        // Arrange
        let item: ClassifiedAd = .stub
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        XCTAssertEqual(viewControllerSpy.invokedDisplayParameters?.viewModel.cells.count, 4)
    }
    
    func test_buildHeaderCell() {
        
        // Arrange
        let item: ClassifiedAd = .stub
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        let headerViewModel = viewControllerSpy.invokedDisplayParameters?.viewModel.cells[0] as? DetailItemViewModel.HeaderCell
        XCTAssertEqual(headerViewModel?.imageURL, item.images.thumb)
        XCTAssertEqual(headerViewModel?.titleText, item.title)
        XCTAssertEqual(headerViewModel?.priceText, item.price.withCurrency())
    }
    
    func test_buildBusinessIfNeeded() {
        
        // Arrange
        let item: ClassifiedAd = .stub
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        let businessViewModel = viewControllerSpy.invokedDisplayParameters?.viewModel.cells[1] as? DetailItemViewModel.InformationCell
        XCTAssertEqual(businessViewModel?.infoTitle, "SIRET: ")
        XCTAssertEqual(businessViewModel?.infoSubtitle, item.siret)
    }
    
    func test_buildCategoryIfNeeded() {
        
        // Arrange
        let item: ClassifiedAd = .stub
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        let categoryViewModel = viewControllerSpy.invokedDisplayParameters?.viewModel.cells[2] as? DetailItemViewModel.InformationCell
        XCTAssertEqual(categoryViewModel?.infoTitle, "Category: ")
        XCTAssertEqual(categoryViewModel?.infoSubtitle, item.category?.name)
    }
    
    func test_buildContent() {
        
        // Arrange
        let item: ClassifiedAd = .stub
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        let contentViewModel = viewControllerSpy.invokedDisplayParameters?.viewModel.cells[3] as? DetailItemViewModel.ContentCell
        XCTAssertEqual(contentViewModel?.description, item.description)
    }
    
    func test_ShouldNotBuildBusinessCell() {
        
        // Arrange
        let item: ClassifiedAd = .stubWithoutSiret
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        let infoCells = viewControllerSpy.invokedDisplayParameters?.viewModel.cells
            .compactMap { $0 as? DetailItemViewModel.InformationCell }
        XCTAssertEqual(infoCells?.count, 1)
        XCTAssertNotEqual(infoCells?.first?.infoTitle, "SIRET: ")
    }
    
    func test_ShouldNotBuildCategoryCell() {
        
        // Arrange
        let item: ClassifiedAd = .stubWithoutCategory
        
        // Act
        presenterUnderTesting.present(item: item)
        
        // Assert
        let infoCells = viewControllerSpy.invokedDisplayParameters?.viewModel.cells
            .compactMap { $0 as? DetailItemViewModel.InformationCell }
        XCTAssertEqual(infoCells?.count, 1)
        XCTAssertNotEqual(infoCells?.first?.infoTitle, "Category: ")
    }

}

