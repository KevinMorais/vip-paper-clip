//
//  UITableView+Registrable.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import UIKit

public extension UITableView {

    func register(_ reusableCell: UITableViewCell.Type) {
        register(reusableCell, forCellReuseIdentifier: reusableCell.ReuseIdentifier)
    }

    func dequeueReusableCell<T: Reusable>(_ reusableCell: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reusableCell.ReuseIdentifier) as? T else {
            fatalError()
        }
        return cell
    }
}
