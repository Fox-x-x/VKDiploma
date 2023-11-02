//
//  CommentCell.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 30.05.2023.
//

import UIKit
import SnapKit

class CommentCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // MARK: - avatarView section
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
        label.text = "3"
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
//            make.bottom.equalToSuperview().offset(-100)
        }
        
        containerView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.height.equalTo(20)
        }

        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarView.snp.trailing).offset(8)
            // потом сделать до сердечка
            make.trailing.equalToSuperview()
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
    }

}
