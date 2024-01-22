//
//  LoginViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 28.11.2023.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController {
    weak var flowCoordinator: FeedCoordinator?
    private let loginInspector = LoginInspector()
    
    // контейнер для всего контента на экране
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // scrollView для возможности скролла экрана во время наплыва контента :)
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    // картинка логотипа
    private let logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo-checkmark")
        return logo
    }()
    
    // общий контейнер для texField'ов с логином и паролем и разделителем этих полей
    private let emailAndPassCommonContainer: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.backgroundColor = .systemGray6
        return view
    }()
    
    // UIView контайнер для TextField логина
    private let loginContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    // UIView контайнер для TextField пароля
    private let passwordContainer: UIView = {
        let container = UIView()
        return container
    }()
    
    // textField для ввода логина
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 0
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "email"
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // textField для ввода пароля
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.tag = 1
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .black
        textField.isSecureTextEntry = true
        textField.placeholder = "пароль"
        textField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    // разедитель полей логина и пароля
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    // кнопка Log in
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(named: "orange-pixel"), for: .normal)
        button.setBackgroundImage(UIImage(named: "orange-pixel")?.alpha(0.8), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "orange-pixel")?.alpha(0.8), for: .selected)
        button.setBackgroundImage(UIImage(named: "orange-pixel")?.alpha(0.5), for: .disabled)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = UIActivityIndicatorView.Style.medium
        spinner.color = .white
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        setupLayout()
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
    }
    
    @objc func textChanged(_ textField: UITextField) {
        loginButton.isEnabled = ![loginTextField, passwordTextField].contains { $0.text!.isEmpty }
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            print("keyboardWillShow")
            scrollView.contentInset.bottom = keyboardSize.height + view.safeAreaInsets.bottom
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func loginButtonPressed() {
        // test@m.ru 123456
        guard let email = loginTextField.text, let pass = passwordTextField.text else { return }
        
        loginButton.isEnabled = false
        spinner.startAnimating()
        loginInspector.loginOrRegisterUser(email: email, pass: pass) { [weak self] result in
            guard let self else { return }
            switch result {
                case .failure(let error):
                    handleApiError(error: error, vc: self)
                    spinner.stopAnimating()
                    loginButton.isEnabled = true
                case .success(let user):
                    // user можно будет потом передать в ProfileViewController, когда будем подгружать его инфу. Пока не нужно.
                    self.flowCoordinator?.gotoFeed()
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.equalTo(scrollView.snp.centerX)
            make.centerY.equalTo(scrollView.snp.centerY)
        }
        
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        contentView.addSubview(emailAndPassCommonContainer)
        emailAndPassCommonContainer.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(120)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(100)
        }
        
        emailAndPassCommonContainer.addSubview(loginContainer)
        loginContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(26)
        }
        
        loginContainer.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(loginContainer.snp.width)
            make.height.equalTo(26)
        }
        
        emailAndPassCommonContainer.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        emailAndPassCommonContainer.addSubview(passwordContainer)
        passwordContainer.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(12)
            make.leading.equalTo(loginContainer.snp.leading)
            make.trailing.equalTo(loginContainer.snp.trailing)
            make.height.equalTo(loginContainer.snp.height)
        }
        
        emailAndPassCommonContainer.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(passwordContainer.snp.centerX)
            make.centerY.equalTo(passwordContainer.snp.centerY)
            make.width.equalTo(passwordContainer.snp.width)
            make.height.equalTo(26)
        }
        
        contentView.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(emailAndPassCommonContainer.snp.bottom).offset(16)
            make.leading.equalTo(emailAndPassCommonContainer.snp.leading)
            make.trailing.equalTo(emailAndPassCommonContainer.snp.trailing)
            make.height.equalTo(50)
        }
        
        loginButton.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(100)
            make.centerY.equalToSuperview()
        }
    }

}

extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
