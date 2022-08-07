//
//  ClassifiedAd.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
import PaperClipCategories

public struct ClassifiedAd: Decodable {
    public let id: Int
    public let title: String
    public let categoryId: Int
    public let description: String
    public let isUrgent: Bool
    public let images: ImageURL
    public let price: Float
    public let siret: String?
    public let creationDate: Date
    public var category: ClassifiedCategory?

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case categoryId = "category_id"
        case description
        case isUrgent = "is_urgent"
        case images = "images_url"
        case price
        case siret
        case creationDate = "creation_date"
        case category
    }

    public init(id: Int, title: String, categoryId: Int, description: String, isUrgent: Bool, images: ImageURL, price: Float, siret: String?, creationDate: Date, category: ClassifiedCategory? = nil) {
        self.id = id
        self.title = title
        self.categoryId = categoryId
        self.description = description
        self.isUrgent = isUrgent
        self.images = images
        self.price = price
        self.siret = siret
        self.creationDate = creationDate
        self.category = category
    }

    mutating func set(_ category: ClassifiedCategory?) {
        self.category = category
    }
}
