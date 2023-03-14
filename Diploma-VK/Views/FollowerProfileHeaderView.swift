//
//  FollowerProfileHeaderView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 05.02.2023.
//

import UIKit
import SnapKit

class FollowerProfileHeaderView: UIView {
    
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
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.setTitle("Следить", for: .normal)
        button.setTitleColor(ColorPalette.thirdColor, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let messageButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.setTitle("Сообщение", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.setTitle("Позвонить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let topHorizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarView.layer.cornerRadius = avatarView.frame.width / 2
    }
    
    private func setupLayout() {
        backgroundColor = .white
        
        addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-200)
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
        
        addSubview(messageButton)
        messageButton.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.44)
            make.height.equalTo(44)
        }
        
        addSubview(callButton)
        callButton.snp.makeConstraints { make in
            make.top.equalTo(messageButton.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.leading.greaterThanOrEqualTo(messageButton.snp.trailing).offset(8)
            make.width.equalToSuperview().multipliedBy(0.44)
            make.height.equalTo(44)
        }
        
        addSubview(topHorizontalSeparator)
        topHorizontalSeparator.snp.makeConstraints { make in
            make.top.equalTo(messageButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(0.5)
        }
    }
    
}

