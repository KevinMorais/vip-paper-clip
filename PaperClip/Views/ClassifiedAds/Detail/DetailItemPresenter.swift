//
//  DetailItemPresenter.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import Foundation
import PaperClipClassifiedAds

protocol DetailItemPresenterInput: AnyObject {
    func present(item: ClassifiedAd)
}

final class DetailItemPresenter {

    private weak var viewController: DetailItemViewControllerInput?

    init(viewController: DetailItemViewControllerInput?) {
        self.viewController = viewController
    }

    private func buildContent(_ item: ClassifiedAd) -> DetailItemViewModel.Content {
        var cells = [
            buildHeaderCell(item)
        ]
        if let cell = buildBusinessCellIfNeeded(item) {
            cells.append(cell)
        }
        if let cell = buildCategoryCellIfNeeded(item) {
            cells.append(cell)
        }
        cells.append(buildContentCell(item))
        return .init(cells: cells)
    }

    private func buildHeaderCell(_ item: ClassifiedAd) -> DetailItemViewModelCell {
        return DetailItemViewModel.HeaderCell(
            imageURL: item.images.thumb,
            titleText: item.title,
            priceText: item.price.withCurrency()
        )
    }

    private func buildBusinessCellIfNeeded(_ item: ClassifiedAd) -> DetailItemViewModelCell? {
        guard let siret = item.siret else {
            return nil
        }
        return DetailItemViewModel.InformationCell(
            infoTitle: "SIRET: ",
            infoSubtitle: siret
        )
    }

    private func buildCategoryCellIfNeeded(_ item: ClassifiedAd) -> DetailItemViewModelCell? {
        guard let categoryName = item.category?.name else {
            return nil
        }
        return DetailItemViewModel.InformationCell(
            infoTitle: "Category: ",
            infoSubtitle: categoryName
        )
    }

    private func buildContentCell(_ item: ClassifiedAd) -> DetailItemViewModelCell {
        return DetailItemViewModel.ContentCell(
            description: item.description
        )
    }
}

// MARK: - DetailItemPresenterInput 
extension DetailItemPresenter: DetailItemPresenterInput {
    func present(item: ClassifiedAd) {
        let viewModel = buildContent(item)
        viewController?.display(viewModel)
    }
}
