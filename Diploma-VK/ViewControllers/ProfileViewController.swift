//
//  ProfileViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 18.04.2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
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
    
    private lazy var photos = ["beauty", "black", "club", "eternal_sunshine"]
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemOrange
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        return view
    }()
    
    // add a tableView. A block with 4 photos will be a special cell of the tableView
    // with a 0 section. ProfileHeaderView -- is the header view of the table (header for section)
    // think over the approach to implement multi header for section
    
    private lazy var postsTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(PostCell.self, forCellReuseIdentifier: String(describing: PostCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(PostsTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: PostsTableHeaderView.self))
        tableView.register(ProfileHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: String(describing: ProfileHeaderView.self))
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
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

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 1
        } else {
            return posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self), for: indexPath) as? PhotosTableViewCell {
                cell.photos = photos
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostCell.self), for: indexPath) as? PostCell {
                cell.postData = posts[indexPath.row]
                return cell
            } else {
                return UITableViewCell()
            }
        }

        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileHeaderView.self)) as? ProfileHeaderView {
                
                header.onEditButtonTap = { [weak self] in
                    self?.navigationController?.pushViewController(EditInfoViewController(), animated: true)
                }
                return header
                
            } else {
                return nil
            }
            
        } else if section == 1 {
            return nil
        } else {
            if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: PostsTableHeaderView.self)) as? PostsTableHeaderView {
                return header
            } else {
                return nil
            }
        }
        
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1, indexPath.row == 0 {
            navigationController?.pushViewController(PhotoGalleryViewController(), animated: true)
        }
    }
}
