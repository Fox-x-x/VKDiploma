//
//  Coordinator.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 18.04.2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
