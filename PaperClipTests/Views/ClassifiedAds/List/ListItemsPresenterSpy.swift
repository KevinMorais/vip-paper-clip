//
//  ListItemsPresenterSpy.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
import PaperClipClassifiedAds
@testable import PaperClip

class ListItemsPresenterSpy: ListItemsPresenterInput {

    var invokedPresentLoading = false
    var invokedPresentLoadingCount = 0
    var invokedPresentLoadingParameters: (loading: Bool, items: [ClassifiedAd])?
    var invokedPresentLoadingParametersList = [(loading: Bool, items: [ClassifiedAd])]()

    func present(loading: Bool, items: [ClassifiedAd]) {
        invokedPresentLoading = true
        invokedPresentLoadingCount += 1
        invokedPresentLoadingParameters = (loading, items)
        invokedPresentLoadingParametersList.append((loading, items))
    }

    var invokedPresentDetail = false
    var invokedPresentDetailCount = 0

    func presentDetail() {
        invokedPresentDetail = true
        invokedPresentDetailCount += 1
    }

    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (error: Error, Void)?
    var invokedPresentParametersList = [(error: Error, Void)]()

    func present(error: Error) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (error, ())
        invokedPresentParametersList.append((error, ()))
    }
}

final class ListItemsPresenterSpyExpectation: ListItemsPresenterSpy {
    
    var expectationNotLoading: XCTestExpectation?
    
    override func present(loading: Bool, items: [ClassifiedAd]) {
        super.present(loading: loading, items: items)
        if !loading {
            expectationNotLoading?.fulfill()
        }
    }
}
