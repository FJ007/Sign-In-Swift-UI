//
//  RegistrationUserVM.swift
//  SignIn
//
//  Created by Javier Fernández on 09/06/2020.
//  Copyright © 2020 Silversun Studio. All rights reserved.
//

import Foundation
import Combine

// https://developer.apple.com/documentation/combine/receiving_and_handling_events_with_combine

class RegistrationUserVM: ObservableObject {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var usernameLengthValid = false
    @Published var passwordLengthValid = false
    @Published var passwordUpperLowercassedValid = false
    @Published var passwordsMatch = false
    
    private var cancellableObjects: Set<AnyCancellable> = [] 
    
    init() {
        $username
            .receive(on: RunLoop.main) // Main thread. Why? Update your view.
            .map { username in
                return username.count >= 6
            }
            .assign(to: \.usernameLengthValid, on: self)
            .store(in: &cancellableObjects)
        $password
            .receive(on: RunLoop.main)
            .map { password in
                return password.count >= 8
            }
            .assign(to: \.passwordLengthValid, on: self)
            .store(in: &cancellableObjects)
        $password
            .receive(on: RunLoop.main)
            .map { password in
                let patternUppercassed = "[A-Z]"
                let patternLowercassed = "[a-z]"
                let patternNumbers = "[0-1]"
                
                guard let _ = password.range(of: patternUppercassed, options: .regularExpression) else {
                    return false
                }
                guard let _ = password.range(of: patternLowercassed, options: .regularExpression) else {
                    return false
                }
                guard let _ = password.range(of: patternNumbers, options: .regularExpression) else {
                    return false
                }
                return true
            }
            .assign(to: \.passwordUpperLowercassedValid, on: self)
            .store(in: &cancellableObjects)
        Publishers.CombineLatest($password, $confirmPassword)
            .receive(on: RunLoop.main)
            .map { (password, confirmPassword) in
                return !password.isEmpty && (password == confirmPassword)
            }
            .assign(to: \.passwordsMatch, on: self)
            .store(in: &cancellableObjects)
    }
    
    
}
