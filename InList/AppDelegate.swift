//
//  AppDelegate.swift
//  InList
//
//  Created by Idris on 14/04/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
		let controller = HomeViewController()
		let navigationController = UINavigationController(rootViewController: controller)
		navigationController.navigationItem.largeTitleDisplayMode = .never
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
		return true
	}
}

