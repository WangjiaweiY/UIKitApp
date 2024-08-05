//
//  LoginView.swift
//  Jiawei666
//
//  Created by 王嘉炜 on 2024/7/22.
//

import UIKit

protocol Navigator: NSObjectProtocol {
    func pushNavigation(VC: UIViewController)
    func popNavigation(VC: UIViewController)
}

class LoginView: UIView, UITextFieldDelegate {
    
    let viewModel: LoginViewModel
    
    weak var delegate: Navigator?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "请登录"
        label.textColor = UIColor.black
        return label
    }()
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        return textField
    }()
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    lazy var usernameWarningTitle: UILabel = {
        let label = UILabel()
        label.text = "用户名至少需要5个英文字符!"
        label.textColor = .red
        return label
    }()
    lazy var passwordWarningTitle: UILabel = {
        let label = UILabel()
        label.text = "密码至少需要10个字符!"
        label.textColor = .red
        return label
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        constructViewHierarchy()
        activateConstraints()
        bindInteraction()
    }
}

extension LoginView {
    func constructViewHierarchy() {
        usernameWarningTitle.isHidden = true
        passwordWarningTitle.isHidden = true
        addSubview(titleLabel)
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(usernameWarningTitle)
        addSubview(passwordWarningTitle)
    }
    
    func activateConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        usernameWarningTitle.translatesAutoresizingMaskIntoConstraints = false
        passwordWarningTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            usernameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            usernameWarningTitle.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            usernameWarningTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            usernameWarningTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameWarningTitle.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            passwordWarningTitle.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            passwordWarningTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordWarningTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: passwordWarningTitle.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func bindInteraction() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped(_ sender: UIButton) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if viewModel.login(username: username, password: password) {
            debugPrint("Login successful, username: " + username + " password: " + password)
            let AiNoiseReductionVC = AINoiseReductionViewController()
            delegate?.pushNavigation(VC: AiNoiseReductionVC)
        } else {
            debugPrint("Login failed")
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // 检查文本字段内容并更新警告标签的显示状态
        updateWarningLabels(for: textField)
    }
    
    // 更新警告标签的显示状态
    private func updateWarningLabels(for textField: UITextField) {
        if textField == usernameTextField {
            // 检查用户名是否至少有5个字符
            let isUsernameValid = (textField.text?.count ?? 0) >= 5
            usernameWarningTitle.isHidden = isUsernameValid
        } else if textField == passwordTextField {
            // 检查密码是否至少有10个字符
            let isPasswordValid = (textField.text?.count ?? 0) >= 10
            passwordWarningTitle.isHidden = isPasswordValid
        }
    }
}
