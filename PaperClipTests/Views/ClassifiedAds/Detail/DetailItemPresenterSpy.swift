//
//  DetailItemPresenterSpy.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//  
//

import XCTest
import PaperClipClassifiedAds
@testable import PaperClip

final class DetailItemPresenterSpy: DetailItemPresenterInput {

    var invokedPresent = false
    var invokedPresentCount = 0
    var invokedPresentParameters: (item: ClassifiedAd, Void)?
    var invokedPresentParametersList = [(item: ClassifiedAd, Void)]()

    func present(item: ClassifiedAd) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (item, ())
        invokedPresentParametersList.append((item, ()))
    }
}
