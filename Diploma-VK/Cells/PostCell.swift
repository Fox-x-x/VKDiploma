//
//  PostCell.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 20.09.2022.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    var onMoreButtonTap: (() -> Void)?
    
    var postData: Post? {
        didSet {
            guard let postData else { return }
            nameLabel.text = postData.name
            jobLabel.text = postData.job
//            postContentText.text = postData.text
        }
    }
    
    private lazy var avatarView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cat-3")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 30
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "Котофей Иванович"
        return label
    }()
    
    private var jobLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "Дизайнер"
        return label
    }()
    
    private let postContentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.secondaryColor
        return view
    }()
    
    private let verticalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.thirdColor
        return view
    }()
    
    private var postBodyBackground: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.secondaryColor
        return view
    }()

    private var postText: UILabel = {
        let tv = UILabel()
        tv.numberOfLines = 4
        tv.textColor = .black
        tv.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        tv.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"
        return tv
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("показать польностью...", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
        return button
    }()
    
    private var postImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .systemOrange
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let horizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    let bottomControlPanel = PostControlPanel(
        likesCount: 42,
        commentsCount: 39,
        isBookmarked: false,
        leadingOffset: 57
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func moreButtonTap() {
        onMoreButtonTap?()
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(avatarView.snp.trailing).offset(16)
        }

        contentView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        
        contentView.addSubview(postContentView)
        postContentView.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        postContentView.addSubview(verticalSeparator)
        postContentView.addSubview(horizontalSeparator)
        verticalSeparator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalTo(horizontalSeparator.snp.top).offset(-16)
            make.width.equalTo(1)
        }
        
        postContentView.addSubview(postText)
        postText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(verticalSeparator.snp.trailing).offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        postContentView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom)
            make.leading.equalTo(postText.snp.leading)
            make.height.equalTo(18)
        }
        
        postContentView.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(8)
            make.leading.equalTo(postText.snp.leading)
            make.trailing.equalTo(postText.snp.trailing)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
            make.height.equalTo(120)
        }
        
        horizontalSeparator.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        postContentView.addSubview(bottomControlPanel)
        bottomControlPanel.snp.makeConstraints { make in
            make.top.equalTo(horizontalSeparator.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    }
    
}
