//
//  AppDelegate.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 27.03.2022.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    var tabBarController = UITabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        mainCoordinator = AppCoordinator(tabBarController: tabBarController)
        mainCoordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator?.tabBarController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        
//
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = LoginViewController()
//        window?.makeKeyAndVisible()
        
        return true
    }

}

