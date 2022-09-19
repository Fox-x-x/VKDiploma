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
    
    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }
    
    func start() {
        let vc = FeedViewController()
        vc.title = "Главная"
        navigationController.pushViewController(vc, animated: true)
    }
    
}
