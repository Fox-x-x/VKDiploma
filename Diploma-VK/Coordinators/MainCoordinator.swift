//
//  MainCoordinator.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 18.04.2022.
//

import UIKit

protocol MainCoordinator {
    
    var tabBarController: UITabBarController { get set }
    var flowCoordinators: [FlowCoordinator] { get set }

    func start()
}
