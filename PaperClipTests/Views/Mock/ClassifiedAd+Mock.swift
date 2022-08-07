//
//  ClassifiedAd+Mock.swift
//  PaperClipTests
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation
import PaperClipClassifiedAds

extension ClassifiedAd {
    
    static var stub: ClassifiedAd {
        return .init(
            id: 1,
            title: "iPhone 13 Pro",
            categoryId: 1,
            description: "Good quality",
            isUrgent: false,
            images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
            price: 999.0,
            siret: "1234539489384",
            creationDate: Date(),
            category: .init(id: 1, name: "Tech")
        )
    }
    
    static var stubWithoutSiret: ClassifiedAd {
        return .init(
            id: 1,
            title: "iPhone 13 Pro",
            categoryId: 1,
            description: "Good quality",
            isUrgent: false,
            images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
            price: 999.0,
            siret: nil,
            creationDate: Date(),
            category: .init(id: 1, name: "Tech")
        )
    }
    
    static var stubWithoutCategory: ClassifiedAd {
        return .init(
            id: 1,
            title: "iPhone 13 Pro",
            categoryId: -1,
            description: "Good quality",
            isUrgent: false,
            images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
            price: 999.0,
            siret: "ZEZEZEZE",
            creationDate: Date(),
            category: nil
        )
    }
    
    
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
                creationDate: Date(),
                category: .init(id: 1, name: "Tech")
            ),
            .init(
                id: 20,
                title: " Glass",
                categoryId: 1,
                description: "Stolen from Foxconn",
                isUrgent: true,
                images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
                price: 2500.0,
                siret: nil,
                creationDate: Date(),
                category: .init(id: 1, name: "Entertainment")
            ),
            .init(
                id: 30,
                title: "Apple Watch 7",
                categoryId: 1,
                description: "95% battery",
                isUrgent: false,
                images: .init(small: URL(string: "https://www.apple.com/small"), thumb: URL(string: "https://www.apple.com/thumb")),
                price: 200.0,
                siret: "121212",
                creationDate: Date(),
                category: .init(id: 1, name: "Tech")
            )
        ]
    }
}
