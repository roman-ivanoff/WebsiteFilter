//
//  AppDelegate.swift
//  WebsiteFilter
//
//  Created by Roman Ivanov on 16.11.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ViewController()
        let navigatorController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigatorController
        window.makeKeyAndVisible()
        self.window = window

        return true
    }
}

