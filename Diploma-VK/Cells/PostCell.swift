//
//  PostCell.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 20.09.2022.
//

import UIKit
import SnapKit

class PostCell: UITableViewCell {
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.backgroundColor = .systemGray5
        label.text = "dymmy label test"
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
        contentView.backgroundColor = .white
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
}
