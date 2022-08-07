//
//  UITableView+Reusable.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import UIKit

public protocol Reusable {
    static var ReuseIdentifier: String { get }
}

public extension Reusable where Self: UITableViewCell {
    static var ReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
