//
//  ClassifiedAdsNavigationController.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit

final class ClassifiedAdsNavigationController: UINavigationController {

    override init(rootViewController: UIViewController = ListItemsViewController()) {
        super.init(rootViewController: rootViewController)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.prefersLargeTitles = true
    }

}
