//
//  PostsTableHeaderView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 02.10.2022.
//

import UIKit
import SnapKit

class PostsTableHeaderView: UITableViewHeaderFooterView {
    
    private var dateLabel: UILabel = {
        let label = PaddingLabel(withInsets: 4, 4, 16, 16)
        label.layer.borderWidth = 0.5
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.cornerRadius = 8
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = ColorPalette.thirdColor
        label.text = "23 июля"
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        return label
    }()
    
    private var leadingSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.thirdColor
        return view
    }()
    
    private var trailingSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorPalette.thirdColor
        return view
    }()
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            
            make.top.equalToSuperview().offset(8)
//            make.leading.equalToSuperview().offset(8)
//            make.trailing.equalToSuperview().offset(-8)
            make.bottom.lessThanOrEqualToSuperview().offset(-8)
        }
        
        contentView.addSubview(leadingSeparator)
        leadingSeparator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(dateLabel.snp.leading).offset(-16)
            make.height.equalTo(0.5)
        }
        
        contentView.addSubview(trailingSeparator)
        trailingSeparator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(dateLabel.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(0.5)
        }
        
    }
    
}
