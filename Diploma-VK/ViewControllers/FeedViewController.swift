//
//  NextViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 11.04.2022.
//

import UIKit
import SkeletonView
import SnapKit

class FeedViewController: UIViewController {
    
    weak var flowCoordinator: FeedCoordinator?
    
//    weak var coordinator: MainCoordinator?
    
    private let randomText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    private lazy var posts: [Post] = [
        Post(name: "Котофей Иванович", job: "Дизайнер", text: randomText),
        Post(name: "Хрен Владимирович", job: "Псих-одиночка", text: randomText),
        Post(name: "Уася", job: "Кот", text: randomText),
        Post(name: "Jason Williams", job: "Film director", text: randomText),
        Post(name: "Jennifer", job: "doctor", text: randomText),
        Post(name: "Sam Fisher", job: "Spy", text: randomText),
        Post(name: "Donald Trump", job: "President of USA", text: randomText),
        Post(name: "John", job: "Какой-то упырь", text: randomText),
        Post(name: "Unnamed", job: "trust-me-not", text: randomText),
        Post(name: "Козёл", job: "пивовар", text: randomText),
        Post(name: "Котофей Иванович", job: "Дизайнер", text: randomText),
        Post(name: "Хрен Владимирович", job: "Псих-одиночка", text: randomText),
        Post(name: "Уася", job: "Кот", text: randomText),
        Post(name: "Jason Williams", job: "Film director", text: randomText),
        Post(name: "Jennifer", job: "doctor", text: randomText),
        Post(name: "Sam Fisher", job: "Spy", text: randomText),
        Post(name: "Donald Trump", job: "President of USA", text: randomText),
        Post(name: "John", job: "Какой-то упырь", text: randomText),
        Post(name: "Unnamed", job: "trust-me-not", text: randomText),
        Post(name: "Козёл", job: "пивовар", text: randomText),
    ]
    
    private lazy var postsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        tableView.register(PostsTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: PostsTableHeaderView.self))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as? PostCell {
            cell.postData = posts[indexPath.row]
            
            cell.onMoreButtonTap = { [weak self] in
                self?.navigationController?.pushViewController(PostViewController(), animated: true)
            }
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return UIView() }

        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: PostsTableHeaderView.self)) as? PostsTableHeaderView {
            return header
        } else {
            return UIView()
        }
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
