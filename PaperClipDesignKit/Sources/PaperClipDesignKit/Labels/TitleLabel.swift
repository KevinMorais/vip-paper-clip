//
//  File.swift
//  
//
//  Created by Kevin Morais on 06/08/2022.
//

import Foundation
import UIKit

final public class TitleLabel: UILabel {

    public init() {
        super.init(frame: .zero)
        font = .titleLarge
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
