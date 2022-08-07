//
//  ListItemsPresenter.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import Foundation
import PaperClipClassifiedAds

protocol ListItemsPresenterInput: AnyObject {
    func present(loading: Bool, items: [ClassifiedAd])
    func presentDetail()
    func present(error: Error)
}

final class ListItemsPresenter {

    private weak var viewController: ListItemsViewControllerInput?

    init(viewController: ListItemsViewControllerInput?) {
        self.viewController = viewController
    }

    private func buildContent(isLoading: Bool, items: [ClassifiedAd]) -> ListItemsViewModel.Content {
        return .init(
            title: "Classified Ads",
            isActivityLoading: isLoading,
            cells: buildCells(items: items)
        )
    }

    private func buildCells(items: [ClassifiedAd]) -> [ListItemsViewModel.Cell] {
        return items.compactMap {
            .init(
                title: $0.title,
                imageURL: $0.images.small ?? $0.images.thumb,
                isImportant: $0.isUrgent,
                creationText: $0.creationDate.smallFormat(),
                priceText: $0.price.withCurrency()
            )
        }
    }
}

// MARK: - ListItemsPresenterInput 
extension ListItemsPresenter: ListItemsPresenterInput {

    func present(loading: Bool, items: [ClassifiedAd]) {
        let viewModel = buildContent(isLoading: loading, items: items)
        viewController?.display(viewModel)
    }

    func presentDetail() {
        viewController?.displayDetail()
    }

    func present(error: Error) {
        viewController?.display(error, retryHandler: { [weak self] in
            self?.viewController?.retry()
        })
    }
}
