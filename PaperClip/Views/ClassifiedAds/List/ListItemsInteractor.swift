//
//  ListItemsInteractor.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import Foundation
import PaperClipClassifiedAds

protocol ListItemsInteractorInput: AnyObject {
    func loadContent()
    func userDidSelectItem(at index: Int)
}

final class ListItemsInteractor: ListItemsDataStore {

    struct Dependencies {
        let classifiedFeature: PaperClipClassifiedAds
        init(classifiedFeature: PaperClipClassifiedAds = PaperClipClassifiedAdsImpl()) {
            self.classifiedFeature = classifiedFeature
        }
    }

    // MARK: - Properties
    private var presenter: ListItemsPresenterInput?
    private let dependencies: Dependencies
    private var classifiedAds: [ClassifiedAd] = []

    // MARK: - ListItemsDataStore
    var selectedItem: ClassifiedAd!

    init(
        presenter: ListItemsPresenterInput?,
        dependencies: Dependencies = .init()
    ) {
        self.presenter = presenter
        self.dependencies = dependencies
    }

    private func fetchItems() {
        dependencies.classifiedFeature.fetch { [weak self] result in
            switch result {
            case .success(let classifiedAds):
                let reordered = self?.makeUrgentsFirst(classifiedAds) ?? []
                self?.classifiedAds = reordered
                self?.presenter?.present(loading: false, items: reordered)
            case .failure(let error):
                self?.presenter?.present(loading: false, items: [])
                self?.presenter?.present(error: error)
            }
        }
    }

    private func makeUrgentsFirst(_ classifiedAds: [ClassifiedAd]) -> [ClassifiedAd] {
        return classifiedAds.sorted { $0.isUrgent && !$1.isUrgent }
    }

}

// MARK: - ListItemsInteractorInput
extension ListItemsInteractor: ListItemsInteractorInput {

    func loadContent() {
        presenter?.present(loading: true, items: [])
        fetchItems()
    }

    func userDidSelectItem(at index: Int) {
        guard classifiedAds.count > index else {
            return
        }
        selectedItem = classifiedAds[index]
        presenter?.presentDetail()
    }

}
