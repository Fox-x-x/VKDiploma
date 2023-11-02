//
//  CommentsListView.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 03.10.2023.
//

import UIKit
import SnapKit

class CommentsListView: UIView {
    
    var comments: [PostComment]? {
        didSet {
            guard let comments else { return }
            setComments()
        }
    }
    
    private let commentsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution = .fill
        sv.spacing = 8
//        sv.backgroundColor = .systemOrange
        return sv
    }()
    
    init(comments: [PostComment]) {
        super.init(frame: .zero)
        self.comments = comments
        setupLayout()
    }
    
    init() {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(commentsStackView)
        commentsStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setComments() {
        guard let comments else { return }
        
        for comment in comments {
            let newCommentView = CommentView(username: comment.username,
                                             text: comment.text,
                                             date: comment.date,
                                             likesCount: comment.likesCount
            )
            commentsStackView.addArrangedSubview(newCommentView)
        }
    }
}
