//
//  UIFont+Italic.swift
//  PaperClip
//
//  Created by Kevin Morais on 06/08/2022.
//

import UIKit

// swiftlint:disable all force_unwrapping
extension UIFont {

    var italic: UIFont {
        return .init(descriptor: fontDescriptor.withSymbolicTraits(.traitItalic)!, size: 0)
    }
}
