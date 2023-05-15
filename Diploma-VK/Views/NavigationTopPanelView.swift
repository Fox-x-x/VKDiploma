//
//  NavigationTopPanelView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 05.03.2023.
//

import UIKit
import SnapKit

enum NavButtonType: String {
    case backArrow = "arrow-left"
    case plus = "plus"
    case tick = "tick"
    case cross = "cross"
    case none = ""
}

class NavigationTopPanelView: UIView {
    
    var onLeftButtonTap: (() -> Void)?
    var onRightButtonTap: (() -> Void)?
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorPalette.fifthColor
        button.addTarget(self, action: #selector(leftButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.tintColor = ColorPalette.fifthColor
        button.addTarget(self, action: #selector(rightButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.thirdColor
        return view
    }()
    
    init(title: String, leftButton: NavButtonType, rightButton: NavButtonType) {
        super.init(frame: .zero)
        
        self.title.text = title
        
        if leftButton != .none {
            self.leftButton.setImage(UIImage(named: leftButton.rawValue)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        if rightButton != .none {
            self.rightButton.setImage(UIImage(named: rightButton.rawValue)?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func leftButtonDidTap() {
        onLeftButtonTap?()
    }
    
    @objc private func rightButtonDidTap() {
        onRightButtonTap?()
    }
    
    private func setupLayout() {
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(30)
            make.height.equalTo(24)
        }
        
        addSubview(title)
        title.snp.makeConstraints { make in
            make.leading.equalTo(leftButton.snp.trailing).offset(32)
            make.centerY.equalTo(leftButton.snp.centerY)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.top.equalTo(leftButton.snp.top)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        addSubview(separator)
        separator.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
            make.bottom.equalToSuperview()
        }
    }
    
    
}
