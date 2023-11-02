//
//  PostViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 11.03.2023.
//

import UIKit
import SnapKit

class PostViewController: UIViewController {
    
    private var commentBarNoKeyboardBottomConstraint: Constraint?
    private var commentBarWithKeyboardBottomConstraint: Constraint?
    
    private var keyboardHeight: CGFloat = 0
    
    private let randomText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\n Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    
    // MARK: - navigation top view
    private let topNavigationView = NavigationTopPanelView(
        title: "Публикации",
        leftButton: .backArrow,
        rightButton: .none
    )
    
    // MARK: - scrollView and content
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .systemGreen
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(onRefreshStart), for: .valueChanged)
        return rc
    }()
    
    // MARK: - avatarView section
    private let avatarView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "cat-3")
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 15
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
    
    private var jobLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Дизайнер"
        return label
    }()
    
    // MARK: - post image
    private let postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "giraffe")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    // MARK: - post text
    private lazy var postText: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        label.text = randomText
        return label
    }()
    
    // MARK: - bottom panel (like, comment, bookmark)
    let bottomControlPanel = PostControlPanel(likesCount: 42, commentsCount: 39, isBookmarked: true)
    
    private let horizontalSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray3
        return view
    }()
    
    // MARK: - comments section
    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.fourthColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "40 комментариев"
        return label
    }()
    
//    private let commentsStackView: UIStackView = {
//        let sv = UIStackView()
//        sv.axis = .vertical
//        sv.distribution = .fill
//        sv.spacing = 8
////        sv.backgroundColor = .systemOrange
//        return sv
//    }()
    
    private let commentsListView: CommentsListView = {
        let view = CommentsListView()
        return view
    }()
    
    private let postCommentBar: PostCommentBar = {
        let view = PostCommentBar()
//        view.backgroundColor = ColorPalette.secondaryColor
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewDidTap))
        view.addGestureRecognizer(gestureRecognizer)
        
        topNavigationView.onLeftButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        postCommentBar.onSendButtonTap = {
            print("onSendButtonTap")
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupLayout()
        setComments()
    }
    
    private func setComments() {
        var comments: [PostComment] = []
        
        comments.append(PostComment(username: "Котофей Иванович", text: "lorem ipsum", date: "19 июля", likesCount: "1"))
        comments.append(PostComment(username: "Хрен Владимирович", text: "lorem ipsum dolor sit amet, consecteur adsf asdf asf asdg fsadf asdf j;dg fgsdfg sdfgs dsfgsd dsfg", date: "21 авгруста", likesCount: "42"))
        comments.append(PostComment(username: "Манул", text: "lorem ipsum dolor sit", date: "1 сентября", likesCount: "17"))
        
        commentsListView.comments = comments
        
//        for comment in comments {
//            let newCommentView = CommentView(username: comment.0, text: comment.1, date: comment.2)
//            commentsStackView.addArrangedSubview(newCommentView)
//        }
    }
    
    private func setupLayout() {
        view.addSubview(topNavigationView)
        topNavigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        view.addSubview(postCommentBar)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(topNavigationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-44)
            make.bottom.equalTo(postCommentBar.snp.top)
        }

        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        scrollView.addSubview(refreshControl)
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarView.snp.top)
            make.leading.equalTo(avatarView.snp.trailing).offset(16)
        }
        
        contentView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.bottom.equalTo(avatarView.snp.bottom)
            make.leading.equalTo(nameLabel.snp.leading)
        }
        
        contentView.addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(postImage.snp.width).multipliedBy(0.6)
        }
        
        contentView.addSubview(postText)
        postText.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(bottomControlPanel)
        bottomControlPanel.snp.makeConstraints { make in
            make.top.equalTo(postText.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(horizontalSeparator)
        horizontalSeparator.snp.makeConstraints { make in
            make.top.equalTo(bottomControlPanel.snp.bottom)
            make.leading.equalTo(postText.snp.leading)
            make.trailing.equalTo(postText.snp.trailing)
            make.height.equalTo(0.5)
        }
        
        contentView.addSubview(commentsCountLabel)
        commentsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalSeparator).offset(16)
            make.leading.equalTo(postText.snp.leading)
            make.trailing.equalTo(postText.snp.trailing)
//            make.bottom.lessThanOrEqualToSuperview().offset(-200)
        }
        
        contentView.addSubview(commentsListView)
        commentsListView.snp.makeConstraints { make in
            make.top.equalTo(commentsCountLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        postCommentBar.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            
            commentBarNoKeyboardBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            commentBarWithKeyboardBottomConstraint = make.bottom.equalTo(view.snp.bottom).offset(-keyboardHeight).constraint
        }
        commentBarNoKeyboardBottomConstraint?.activate()
        commentBarWithKeyboardBottomConstraint?.deactivate()
    }
    
    @objc private func onRefreshStart() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc private func viewDidTap() {
        postCommentBar.textView.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            keyboardHeight = keyboardSize.height
            
            UIView.animate(withDuration: 0.3) {
                self.commentBarWithKeyboardBottomConstraint?.update(offset: -self.keyboardHeight)
                self.commentBarNoKeyboardBottomConstraint?.deactivate()
                self.commentBarWithKeyboardBottomConstraint?.activate()
                self.postCommentBar.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide() {
        UIView.animate(withDuration: 0.3) {
            self.commentBarWithKeyboardBottomConstraint?.deactivate()
            self.commentBarNoKeyboardBottomConstraint?.activate()
            self.postCommentBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }
    }

}
