//
//  UIColor+Colors.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit

// swiftlint:disable all force_unwrapping
extension UIColor {

    private static func color(named: String) -> UIColor {
        return .init(named: named, in: .module, compatibleWith: .current)!
    }

    public static let primary: UIColor? = {
        return color(named: "primary")
    }()

    public static let background100: UIColor? = {
        return color(named: "background100")
    }()
}
