//
//  LoginViewController.swift
//  Jiawei666
//
//  Created by 王嘉炜 on 2024/7/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    let viewModel: LoginViewModel
    
    init() {
        viewModel = LoginViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = LoginView(viewModel: viewModel)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginView = LoginView(viewModel: viewModel)
        loginView.translatesAutoresizingMaskIntoConstraints = false
        self.view = loginView
    }
}
