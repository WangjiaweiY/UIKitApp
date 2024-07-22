//
//  LoginViewModel.swift
//  Jiawei666
//
//  Created by 王嘉炜 on 2024/7/22.
//

import Foundation

class LoginViewModel: NSObject {
    
    var username: String = ""
    var password: String = ""
    
    override init() {
        super.init()
    }
    
    func login(username: String, password: String, completion: @escaping (Bool) -> Void) {
        // 这里模拟网络请求
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(username == "admin" && password == "password")
        }
    }
}
