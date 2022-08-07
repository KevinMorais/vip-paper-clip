//
//  File.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
import UIKit

final public class ParagraphLabel: UILabel {

    public init() {
        super.init(frame: .zero)
        font = .caption2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
