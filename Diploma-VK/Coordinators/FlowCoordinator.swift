//
//  FlowCoordinator.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 21.04.2022.
//

import UIKit

protocol FlowCoordinator {
    
    var mainCoordinator: AppCoordinator? { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
