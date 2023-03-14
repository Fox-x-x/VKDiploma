//
//  EditInfoViewController.swift
//  Diploma-VK
//
//  Created by Pavel Yurkov on 05.03.2023.
//

import UIKit
import SnapKit

// MARK: - TextField class
class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

class EditInfoViewController: UIViewController {
    
    private let topNavigationView = NavigationTopPanelView(
        title: "Основная информация",
        leftButton: .cross,
        rightButton: .tick
    )
    
    // MARK: - scrollView and content
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .white
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - name
    private let name: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Имя"
        return label
    }()
    
    private let nameTextField: TextField = {
        let text = TextField()
        text.tintColor = ColorPalette.fourthColor
        text.layer.cornerRadius = 10
        text.backgroundColor = ColorPalette.secondaryColor
        text.placeholder = "Имя"
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return text
    }()
    
    // MARK: - lastName
    private let lastName: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Фамилия"
        return label
    }()
    
    private let lastNameTextField: TextField = {
        let text = TextField()
        text.tintColor = ColorPalette.fourthColor
        text.layer.cornerRadius = 10
        text.backgroundColor = ColorPalette.secondaryColor
        text.placeholder = "Фамилия"
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return text
    }()
    
    // MARK: - gender
    private let gender: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Пол"
        return label
    }()
    
    private let maleButton: RadioButton = {
        let button = RadioButton()
        button.isChecked = true
        return button
    }()
    
    private let male: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "мужской"
        return label
    }()
    
    private let femaleButton: RadioButton = {
        let button = RadioButton()
        button.isChecked = false
        return button
    }()
    
    private let female: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "женский"
        return label
    }()
    
    // MARK: - birthDate
    private let birthDate: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Дата рождения"
        return label
    }()
    
    private let birthTextField: TextField = {
        let text = TextField()
        text.tintColor = ColorPalette.fourthColor
        text.layer.cornerRadius = 10
        text.backgroundColor = ColorPalette.secondaryColor
        text.placeholder = "20.12.2020"
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return text
    }()
    
    // MARK: - city
    private let city: UILabel = {
        let label = UILabel()
        label.textColor = ColorPalette.thirdColor
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.text = "Родной город"
        return label
    }()
    
    private let cityTextField: TextField = {
        let text = TextField()
        text.tintColor = ColorPalette.fourthColor
        text.layer.cornerRadius = 10
        text.backgroundColor = ColorPalette.secondaryColor
        text.placeholder = "20.12.2020"
        text.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return text
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        setupLayout()
        
        topNavigationView.onLeftButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        topNavigationView.onRightButtonTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        maleButton.onTap = { [weak self] in
            guard let self else { return }
            if !self.maleButton.isChecked {
                self.maleButton.isChecked = true
                self.femaleButton.isChecked = false
            }
        }
        
        femaleButton.onTap = { [weak self] in
            guard let self else { return }
            if !self.femaleButton.isChecked {
                self.femaleButton.isChecked = true
                self.maleButton.isChecked = false
            }
        }
    }
    
    private func setupLayout() {
        view.addSubview(topNavigationView)
        topNavigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(topNavigationView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.centerX.top.bottom.equalToSuperview()
        }
        
        contentView.addSubview(name)
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.equalToSuperview().offset(16)
        }

        contentView.addSubview(nameTextField)
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(4)
            make.leading.equalTo(name)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }

        contentView.addSubview(lastName)
        lastName.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(12)
            make.leading.equalTo(name.snp.leading)
        }

        contentView.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastName.snp.bottom).offset(4)
            make.leading.equalTo(name)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(gender)
        gender.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(12)
            make.leading.equalTo(name.snp.leading)
        }
        
        contentView.addSubview(maleButton)
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(gender.snp.bottom).offset(12)
            make.leading.equalTo(name.snp.leading)
            make.width.height.equalTo(16)
        }
        
        contentView.addSubview(male)
        male.snp.makeConstraints { make in
            make.leading.equalTo(maleButton.snp.trailing).offset(16)
            make.centerY.equalTo(maleButton.snp.centerY)
        }
        
        contentView.addSubview(femaleButton)
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom).offset(12)
            make.leading.equalTo(name.snp.leading)
            make.width.height.equalTo(16)
        }
        
        contentView.addSubview(female)
        female.snp.makeConstraints { make in
            make.leading.equalTo(femaleButton.snp.trailing).offset(16)
            make.centerY.equalTo(femaleButton.snp.centerY)
        }
        
        contentView.addSubview(birthDate)
        birthDate.snp.makeConstraints { make in
            make.top.equalTo(femaleButton.snp.bottom).offset(32)
            make.leading.equalTo(name.snp.leading)
        }
        
        contentView.addSubview(birthTextField)
        birthTextField.snp.makeConstraints { make in
            make.top.equalTo(birthDate.snp.bottom).offset(4)
            make.leading.equalTo(name)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(city)
        city.snp.makeConstraints { make in
            make.top.equalTo(birthTextField.snp.bottom).offset(12)
            make.leading.equalTo(name.snp.leading)
        }
        
        contentView.addSubview(cityTextField)
        cityTextField.snp.makeConstraints { make in
            make.top.equalTo(city.snp.bottom).offset(4)
            make.leading.equalTo(name)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.bottom.lessThanOrEqualToSuperview().offset(-64)
        }
        
    }

}
