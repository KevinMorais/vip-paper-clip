//
//  UIImageView+URL.swift
//  
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit
import PaperClipNetworkCore

extension UIImageView {

    private static var _url: [String: String] = [:]

    private var url: String? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIImageView._url[tmpAddress] ?? nil
        }
        set {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIImageView._url[tmpAddress] = newValue
        }
    }

    enum Constants {
        fileprivate static let failedImage: UIImage? = .init(systemName: "exclamationmark.circle")
        fileprivate static let api: APIClient = APIClientImpl()
    }

    public func set(url: URL?) {
        guard url?.absoluteString != self.url else {
            return
        }
        guard let url = url else {
            return
        }
        addActivityIndicator()
        Constants.api.get(url: url) { result in
            switch result {
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure:
                self.image = Constants.failedImage
            }
            self.removeActivityIndicator()
        }
    }

    private func addActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .darkGray
        image = nil
        addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }

    private func removeActivityIndicator() {
        subviews.first(where: { $0 is UIActivityIndicatorView })?.removeFromSuperview()
    }

}
