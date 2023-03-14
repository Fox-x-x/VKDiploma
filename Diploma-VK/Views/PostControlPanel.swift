//
//  PostControlPanel.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 13.03.2023.
//

import UIKit
import SnapKit

class PostControlPanel: UIView {
    
    private var likesCount = 0
    private var commentsCount = 0
    private var isBookmarked = false
    private var leadingOffset = 16
    
    var onLikeButtonTap: (() -> Void)?
    var onCommentsButtonTap: (() -> Void)?
    var onBookmarkButtonTap: (() -> Void)?
    
    private var likeButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.borderless()
        config.image = UIImage(systemName: "heart")
        return config
    }()
    
    private var commentsButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.borderless()
        config.image = UIImage(systemName: "bubble.left")
        return config
    }()
    
    private var bookmarkButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.borderless()
        config.image = UIImage(systemName: "bookmark")
        return config
    }()
    
    private var likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorPalette.thirdColor
        button.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var likesCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "42"
        return label
    }()
    
    private var commentsButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorPalette.thirdColor
        button.addTarget(self, action: #selector(commentsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var commentsCountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "39"
        return label
    }()
    
    private var bookmarkButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorPalette.thirdColor
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()

    init(likesCount: Int, commentsCount: Int, isBookmarked: Bool, leadingOffset: Int = 16) {
        super.init(frame: .zero)
        
        self.likesCount = likesCount
        self.commentsCount = commentsCount
        self.isBookmarked = isBookmarked
        self.leadingOffset = leadingOffset
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = .clear
        
        addSubview(likeButton)
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(leadingOffset)
            make.width.equalTo(25)
            make.height.equalTo(25)
            make.bottom.equalToSuperview().offset(-16)
        }
        likeButton.configuration = likeButtonConfig
        
        addSubview(likesCountLabel)
        likesCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(likeButton.snp.trailing).offset(8)
            make.centerY.equalTo(likeButton.snp.centerY)
        }
        
        addSubview(commentsButton)
        commentsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(likesCountLabel.snp.trailing).offset(32)
            make.width.equalTo(25)
            make.height.equalTo(25)
        }
        commentsButton.configuration = commentsButtonConfig
        
        addSubview(commentsCountLabel)
        commentsCountLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentsButton.snp.trailing).offset(8)
            make.centerY.equalTo(commentsButton.snp.centerY)
        }
        
        addSubview(bookmarkButton)
        bookmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-24)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-21)
        }
        if isBookmarked {
            bookmarkButton.tintColor = ColorPalette.fifthColor
            bookmarkButtonConfig.image = UIImage(systemName: "bookmark.fill")
        }
        bookmarkButton.configuration = bookmarkButtonConfig
        
    }
    
    @objc private func likeButtonTapped() {
        onLikeButtonTap?()
    }
    
    @objc private func commentsButtonTapped() {
        onCommentsButtonTap?()
    }
    
    @objc private func bookmarkButtonTapped() {
        onBookmarkButtonTap?()
    }

}
