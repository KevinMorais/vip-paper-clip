//
//  Date+Formatter.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation

extension Date {

    func smallFormat() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter.string(from: self)
    }

}
