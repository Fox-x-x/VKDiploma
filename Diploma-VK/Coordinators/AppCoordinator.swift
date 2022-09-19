//
//  AppCoordinator.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 21.04.2022.
//

import UIKit

class AppCoordinator: MainCoordinator {
    
    var tabBarController: UITabBarController
    var flowCoordinators = [FlowCoordinator]()
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    let feedNavController: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem.image = UIImage(systemName: "house")
        nc.title = "Главная"
        return nc
    }()
    
    let profileNavController: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem.image = UIImage(systemName: "person")
        nc.title = "Профиль"
        return nc
    }()
    
    let favoritesNavController: UINavigationController = {
        let nc = UINavigationController()
        nc.tabBarItem.image = UIImage(systemName: "heart")
        nc.title = "Сохраненные"
        return nc
    }()
    
    func start() {
        flowCoordinators = [
            FeedCoordinator(navigationController: feedNavController, mainCoordinator: self),
            ProfileCoordinator(navigationController: profileNavController, mainCoordinator: self),
            FavoritesCoordinator(navigationController: favoritesNavController, mainCoordinator: self)
        ]
        
        flowCoordinators.forEach() { $0.start() }
        
        let navControllers = [feedNavController, profileNavController, favoritesNavController]
        tabBarController.setViewControllers(navControllers, animated: true)
        tabBarController.tabBar.backgroundColor = .white
    }
    
}
