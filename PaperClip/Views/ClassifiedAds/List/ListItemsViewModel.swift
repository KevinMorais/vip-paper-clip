//
//  ListItemsViewModel.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import Foundation

enum ListItemsViewModel {
    struct Content {
        let title: String
        let isActivityLoading: Bool
        let cells: [Cell]
    }

    struct Cell {
        let title: String
        let imageURL: URL?
        let isImportant: Bool
        let creationText: String?
        let priceText: String
    }
}
