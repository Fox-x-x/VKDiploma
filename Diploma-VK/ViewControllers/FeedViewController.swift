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
    
    private lazy var postsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemRed
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ColorPalette.primaryColor
        navigationController?.navigationBar.isHidden = false
        
        setupLayout()
        
    }
    
    private func setupLayout() {
        view.addSubview(postsTable)
        postsTable.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as? PostCell {
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    
}
