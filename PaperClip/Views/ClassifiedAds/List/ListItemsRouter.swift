//
//  ListItemsRouter.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
import PaperClipClassifiedAds

protocol ListItemsRouterInput {
    func routeToDetail()
}

protocol ListItemsDataStore: AnyObject {
    var selectedItem: ClassifiedAd! { get set }
}

final class ListItemsRouter: ListItemsRouterInput {

    private weak var dataStore: ListItemsDataStore?

    private weak var viewController: ListItemsViewController?

    init(dataStore: ListItemsDataStore, viewController: ListItemsViewController) {
        self.dataStore = dataStore
        self.viewController = viewController
    }

    func routeToDetail() {
        guard let viewController = viewController else {
            return
        }
        let detailViewController = DetailItemViewController()
        passDataToDetail(source: dataStore, destination: detailViewController.router?.dataStore)
        navigateToDetail(source: viewController, destination: detailViewController)
    }

    private func navigateToDetail(source: ListItemsViewController, destination: DetailItemViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }

    private func passDataToDetail(source: ListItemsDataStore?, destination: DetailItemDataStore?) {
        guard let source = source, let destination = destination else {
            fatalError()
        }
        destination.item = source.selectedItem
    }
}
