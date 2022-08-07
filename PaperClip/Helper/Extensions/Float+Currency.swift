//
//  Float+Currency.swift
//  PaperClip
//
//  Created by Kevin Morais on 07/08/2022.
//

import Foundation

extension Float {

    func withCurrency(locale: Locale = .current) -> String {
        let currencyCode = locale.currencyCode ?? "€"
        return "\(self) \(currencyCode)"
    }
}
