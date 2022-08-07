//
//  File.swift
//  
//
//  Created by Kevin Morais on 07/08/2022.
//

import Foundation
@testable import PaperClipClassifiedAds

extension ClassifiedAd {
    static var stubArray: [ClassifiedAd] {
        return [
            .init(
                id: 1,
                title: "iPhone 13 Pro",
                categoryId: 1,
                description: "Good quality",
                isUrgent: false,
                images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
                price: 999.0,
                siret: "1234539489384",
                creationDate: Date()
            ),
            .init(
                id: 20,
                title: " Glass",
                categoryId: 2,
                description: "Stolen from Foxconn",
                isUrgent: true,
                images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
                price: 2500.0,
                siret: nil,
                creationDate: Date()
            ),
            .init(
                id: 30,
                title: "Apple Watch 7",
                categoryId: 3,
                description: "95% battery",
                isUrgent: false,
                images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
                price: 200.0,
                siret: "121212",
                creationDate: Date()
            )
        ]
    }
}
