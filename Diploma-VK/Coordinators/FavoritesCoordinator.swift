//
//  FavoritesCoordinator.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 21.04.2022.
//

import UIKit

class FavoritesCoordinator: FlowCoordinator {
    
    weak var mainCoordinator: AppCoordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let vc = FavoritesViewController()
        vc.title = "Сохраненные"
        navigationController.pushViewController(vc, animated: true)
    }
    
}
