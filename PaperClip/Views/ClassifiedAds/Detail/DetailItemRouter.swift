//
//  DetailItemRouter.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
import PaperClipClassifiedAds

protocol DetailItemDataPassing {
    var dataStore: DetailItemDataStore? { get set }
}

protocol DetailItemRouterInput {

}

protocol DetailItemDataStore: AnyObject {
    var item: ClassifiedAd! { get set }
}

final class DetailItemRouter: DetailItemRouterInput, DetailItemDataPassing {

    private weak var viewController: DetailItemViewController?
    weak var dataStore: DetailItemDataStore?

    init(dataStore: DetailItemDataStore, viewController: DetailItemViewController) {
        self.dataStore = dataStore
        self.viewController = viewController
    }

}
