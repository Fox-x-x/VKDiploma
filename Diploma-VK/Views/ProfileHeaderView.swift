//
//  ProfileHeaderView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 07.11.2022.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var onEditButtonTap: (() -> Void)?
    
    // MARK: Avatar, name, profession, button
    private let avatarView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cat-3")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Котофей Иванович"
        return label
    }()
    
    private let jobLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Дизайнер"
        return label
    }()
    
    private let birthdayLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "ДР: 31.12.1990"
        return label
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Город: Полесск"
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitle("Редактировать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ColorPalette.fifthColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: posts, followers, separator
    private let postsCount: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "1400"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let followingCount: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "120"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let followersCount: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "431"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let postsCountTitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "публикаций"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let followingCountTitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "подписок"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let followersCountTitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "подписчиков"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let topHorizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    // MARK: create media content icons, labels
    private let createPostImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "square.and.pencil")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.tintColor = ColorPalette.thirdColor
        return image
    }()
    
    private let createStories: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "camera")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.tintColor = ColorPalette.thirdColor
        return image
    }()
    
    private let uploadPhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "photo")
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.tintColor = ColorPalette.thirdColor
        return image
    }()
    
    private let createPostTitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Запись"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let createStoriesTitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "История"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let uploadTitle: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Фото"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
    }
    
    @objc private func editButtonDidTap() {
        onEditButtonTap?()
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        
        // MARK: Layout: Avatar, name, profession, button
        addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(avatarView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(jobLabel.snp.trailing)
        }
        
        addSubview(birthdayLabel)
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(4)
            make.leading.equalTo(jobLabel.snp.leading)
        }
        
        addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(4)
            make.leading.equalTo(birthdayLabel.snp.leading)
        }
        
        addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        // MARK: Layout: posts, followers, separator
        let statisticsStackView = UIStackView(arrangedSubviews: [postsCount, followingCount,followersCount])
        statisticsStackView.axis = .horizontal
        statisticsStackView.distribution = .fillEqually
        statisticsStackView.spacing = 16
        
        addSubview(statisticsStackView)
        statisticsStackView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(25)
            make.leading.equalTo(editButton.snp.leading).offset(8)
            make.trailing.equalTo(editButton.snp.trailing).offset(-8)
        }
        
        let statisticsTitlesStackView = UIStackView(
            arrangedSubviews: [postsCountTitle, followingCountTitle, followersCountTitle]
        )
        statisticsStackView.axis = .horizontal
        statisticsStackView.distribution = .fillEqually
        statisticsStackView.spacing = 16
        
        addSubview(statisticsTitlesStackView)
        statisticsTitlesStackView.snp.makeConstraints { make in
            make.top.equalTo(statisticsStackView.snp.bottom).offset(4)
            make.leading.equalTo(editButton.snp.leading).offset(8)
            make.trailing.equalTo(editButton.snp.trailing).offset(-8)
        }
        
        addSubview(topHorizontalSeparator)
        topHorizontalSeparator.snp.makeConstraints { make in
            make.top.equalTo(statisticsTitlesStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
        }
        
        // MARK: Layout: create media content icons, labels
        let mediaContentStackView = UIStackView(arrangedSubviews: [createPostImage, createStories, uploadPhoto])
        mediaContentStackView.axis = .horizontal
        mediaContentStackView.distribution = .fillEqually
        mediaContentStackView.spacing = 16

        addSubview(mediaContentStackView)
        mediaContentStackView.snp.makeConstraints { make in
            make.top.equalTo(topHorizontalSeparator.snp.bottom).offset(16)
            make.leading.equalTo(statisticsStackView.snp.leading)
            make.trailing.equalTo(statisticsStackView.snp.trailing)
        }

        createPostImage.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        createStories.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        uploadPhoto.snp.makeConstraints { make in
            make.height.equalTo(30)
        }

        let mediaContentTitlesStackView = UIStackView(
            arrangedSubviews: [createPostTitle, createStoriesTitle, uploadTitle]
        )
        mediaContentTitlesStackView.axis = .horizontal
        mediaContentTitlesStackView.distribution = .fillEqually
        mediaContentTitlesStackView.spacing = 16

        addSubview(mediaContentTitlesStackView)
        mediaContentTitlesStackView.snp.makeConstraints { make in
            make.top.equalTo(mediaContentStackView.snp.bottom).offset(4)
            make.leading.equalTo(editButton.snp.leading).offset(8)
            make.trailing.equalTo(editButton.snp.trailing).offset(-8)
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
}
