//
//  DetailItemViewModel.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//  
//

import Foundation

protocol DetailItemViewModelCell {}

enum DetailItemViewModel {

    struct Content {
        let cells: [DetailItemViewModelCell]
    }

    struct HeaderCell: DetailItemViewModelCell {
        let imageURL: URL?
        let titleText: String
        let priceText: String
    }

    struct InformationCell: DetailItemViewModelCell {
        let infoTitle: String?
        let infoSubtitle: String?
    }

    struct ContentCell: DetailItemViewModelCell {
        let description: String?
    }
}
