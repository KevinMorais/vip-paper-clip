//
//  AppDelegate.swift
//  PaperClip
//
//  Created by Kevin Morais on 05/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = .init(frame: UIScreen.main.bounds)
        let listViewController = ClassifiedAdsNavigationController()
        window?.rootViewController = listViewController
        window?.makeKeyAndVisible()
        return true
    }
}
