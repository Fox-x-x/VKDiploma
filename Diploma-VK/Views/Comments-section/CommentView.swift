//
//  CommentView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 17.09.2023.
//

import UIKit

class CommentView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let avatarView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cat-3")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 7.5
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fifthColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "Котофей Иванович"
        return label
    }()
    
    private let commentTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        label.text = "Ну очень интересно, но нихрена не понятно, почему же так происходит..."
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.sixthColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.text = "19 июля"
        return label
    }()
    
    private let likesCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 1
        label.text = "12"
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorPalette.thirdColor
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let likeButtonImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "heart")
        return iv
    }()
    
    init(username: String, text: String, date: String, likesCount: String) {
        super.init(frame: .zero)
        
        self.nameLabel.text = username
        self.commentTextLabel.text = text
        self.dateLabel.text = date
        self.likesCountLabel.text = likesCount
        
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        containerView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(15)
        }

        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarView.snp.trailing).offset(8)
            make.bottom.equalTo(avatarView.snp.bottom)
        }

        containerView.addSubview(commentTextLabel)
        commentTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-8)
        }

        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(commentTextLabel.snp.bottom).offset(2)
            make.leading.equalTo(commentTextLabel.snp.leading)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
        
        containerView.addSubview(likesCountLabel)
        likesCountLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(3)
        }
        
        containerView.addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(likesCountLabel.snp.centerY)
            make.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8)
            make.trailing.equalTo(likesCountLabel.snp.leading).offset(-8)
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        
        likeButton.addSubview(likeButtonImage)
        likeButtonImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc private func likeButtonTapped() {
        print("likeButtonTapped")
    }
}


