//
//  AppDelegate.swift
//  Fishes
//
//  Created by Devs on 2022-09-07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainCoordinator : Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let navController = UINavigationController()
        mainCoordinator = MainCoordinator(navigationController: navController)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        mainCoordinator?.launch()
  
        return true
    }
}

