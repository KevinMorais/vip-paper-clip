//
//  BaseViewController.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit

protocol BaseViewControllerInput: AnyObject {
    func display(_ error: Error, retryHandler: (() -> Void)?)
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    fileprivate func displayAlert(title: String, message: String, handler: (() -> Void)?) {
        let alertController: UIAlertController = .init(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: "Retry", style: .cancel, handler: { _ in handler?() }))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: BaseViewControllerInput
extension BaseViewControllerInput where Self: BaseViewController {

    func display(_ error: Error, retryHandler: (() -> Void)?) {
        let message = error.localizedDescription
        displayAlert(title: "Error", message: message, handler: retryHandler)
    }
}
