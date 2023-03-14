//
//  RadioButton.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 09.03.2023.
//

import UIKit

class RadioButton: UIButton {
    
    var isChecked = false {
        didSet {
            let imageName = isChecked ? "radio-selected" : "radio-empty"
            setImage(UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal), for: .normal)
//            isChecked = isChecked == true ? false : true
        }
    }
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initButton() {
        backgroundColor = .clear
        tintColor = .clear
        setTitle("", for: .normal)
        setImage(UIImage(named: "radio-empty")?.withRenderingMode(.alwaysOriginal), for: .normal)
        setImage(UIImage(named: "radio-selected")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
    }
    
    @objc private func buttonDidTap() {
        onTap?()
    }
}
