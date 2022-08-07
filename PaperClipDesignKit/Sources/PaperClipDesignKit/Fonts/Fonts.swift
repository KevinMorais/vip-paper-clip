//
//  Fonts.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit

extension UIFont {

    public static var titleLarge: UIFont {
        return .preferredFont(forTextStyle: .largeTitle)
    }

    public static var titleMedium: UIFont {
        return .preferredFont(forTextStyle: .title3)
    }

    public static var body: UIFont {
        return .preferredFont(forTextStyle: .body)
    }

    public static var caption2: UIFont {
        return .preferredFont(forTextStyle: .caption2)
    }

}
