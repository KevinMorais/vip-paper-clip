//
//  ActivityIndicator+Toggle.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit

extension UIActivityIndicatorView {

    public func set(animate: Bool) {
        if animate {
            startAnimating()
        } else {
            stopAnimating()
        }
    }

}
