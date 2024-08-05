//
//  LoginViewModel.swift
//  Jiawei666
//
//  Created by 王嘉炜 on 2024/7/22.
//

import Foundation

class LoginViewModel: NSObject {
    
    var user = User(username: "", password: "")
    
    @Published var isLoggedIn: Bool = false
    
    override init() {
        super.init()
    }
    
    func login(username: String, password: String) -> Bool {
        self.user.username = username
        self.user.password = password
        return true
    }
}
