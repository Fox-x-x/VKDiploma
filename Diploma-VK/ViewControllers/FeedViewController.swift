//
//  NextViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 11.04.2022.
//

import UIKit
import Hex
import SkeletonView
import SnapKit

class FeedViewController: UIViewController {
    
//    weak var coordinator: MainCoordinator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
        navigationController?.navigationBar.isHidden = false
        
    }

}
