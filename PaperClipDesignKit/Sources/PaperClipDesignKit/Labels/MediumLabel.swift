//
//  File.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import Foundation
import UIKit

final public class MediumLabel: UILabel {

    public init() {
        super.init(frame: .zero)
        font = .titleMedium
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
