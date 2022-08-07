//
//  DetailItemInteractor.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import Foundation
import PaperClipClassifiedAds

protocol DetailItemInteractorInput: AnyObject {
    func loadContent()
}

final class DetailItemInteractor: DetailItemDataStore {

    // MARK: - Properties
    private var presenter: DetailItemPresenterInput?

    // MARK: - DetailItemDataStore
    var item: ClassifiedAd!

    init(
        presenter: DetailItemPresenterInput?
    ) {
        self.presenter = presenter
    }
}

// MARK: - DetailItemInteractorInput
extension DetailItemInteractor: DetailItemInteractorInput {

    func loadContent() {
        presenter?.present(item: item)
    }
}
