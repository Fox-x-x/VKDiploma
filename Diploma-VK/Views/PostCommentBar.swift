//
//  PostCommentBar.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 15.03.2023.
//

import UIKit
import SnapKit

private enum ui {
    static let minCommentHeight = 36
    static let maxLines = 5
    static let defaultFont = UIFont.systemFont(ofSize: 16, weight: .regular)
}

class PostCommentBar: UIView {
    
    var onSendButtonTap: (() -> Void)?
    
    private var textViewHeightConstraint: Constraint?
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "оставить комментарий"
        textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textView.textColor = ColorPalette.sixthColor
        textView.showsHorizontalScrollIndicator = false
        textView.delegate = self
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private var sendButtonConfig: UIButton.Configuration = {
        var config = UIButton.Configuration.borderless()
        config.image = UIImage(systemName: "paperplane.fill")
        return config
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        button.tintColor = ColorPalette.fifthColor
        button.isEnabled = false
        button.addTarget(self, action: #selector(sendButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = ColorPalette.secondaryColor
        
        addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-4)
            make.centerY.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        sendButton.configuration = sendButtonConfig
        
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalTo(sendButton.snp.leading).offset(-4)
            textViewHeightConstraint = make.height.equalTo(ui.minCommentHeight).constraint
            make.bottom.equalToSuperview().offset(-4)
        }
        textViewHeightConstraint?.activate()
    }
    
    @objc private func sendButtonDidTap() {
        onSendButtonTap?()
    }
    
    private func setTextViewHeight() {
        let lineHeight = textView.font?.lineHeight ?? ui.defaultFont.lineHeight
        let linesCount = min(max(Int(textView.contentSize.height / lineHeight), 1), ui.maxLines)
        let heightToSet = max(CGFloat(linesCount) * lineHeight, CGFloat(ui.minCommentHeight))
        UIView.animate(withDuration: 0.2) {
            self.textView.snp.updateConstraints { make in
                make.height.equalTo(heightToSet)
            }
            self.textView.layoutIfNeeded()
            self.layoutIfNeeded()
        }
    }
    
}

extension PostCommentBar: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == ColorPalette.sixthColor {
            textView.text = nil
            textView.textColor = ColorPalette.seventhColor
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "оставить комментарий"
            textView.textColor = ColorPalette.sixthColor
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let isEmpty = textView.text.isEmpty
        sendButton.isEnabled = !isEmpty
        setTextViewHeight()
    }
}
