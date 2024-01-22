//
//  FeedCoordinator.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 21.04.2022.
//

import UIKit

class FeedCoordinator: FlowCoordinator {
    
    weak var mainCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    private let defaults = UserDefaults.standard
    
    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let isAuthorized = defaults.bool(forKey: "isAuthorized")
        if isAuthorized {
            gotoFeed()
        } else {
            let vc = LoginViewController()
            vc.flowCoordinator = self
            vc.title = "Главная"
            mainCoordinator?.tabBarController.tabBar.isHidden = true
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func gotoFeed() {
        let vc = FeedViewController()
        vc.flowCoordinator = self
        vc.title = "Главная"
        mainCoordinator?.tabBarController.tabBar.isHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
}
