//
//  ContentView.swift
//  SignIn
//
//  Created by Javier Fernández on 08/06/2020.
//  Copyright © 2020 Silversun Studio. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isCreateAccount = true
    @ObservedObject private var registerUser = RegistrationUserVM()
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Email")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(isCreateAccount ? "Create Your Account" : "Login")
                    .font(.largeTitle)
                    .bold()
                SingleFormView(valueUser: $registerUser.username,
                               placeholder: "Username",
                               isSecureField: false)
                if isCreateAccount{
                   ValidationFormView(reason: "It's at least 6 characters.",
                                      reasonCheck: registerUser.usernameLengthValid)
                }
                SingleFormView(valueUser: $registerUser.password,
                               placeholder: "Password",
                               isSecureField: true)
                if isCreateAccount{
                    ValidationFormView(reason: "It's at least 8 characters.",
                                       reasonCheck: registerUser.passwordLengthValid)
                    ValidationFormView(reason: "Make sure including a number, a lowercase and an uppercase letter.",
                                       reasonCheck: registerUser.passwordUpperLowercassedValid)
                    SingleFormView(valueUser: $registerUser.confirmPassword,
                                   placeholder: "Confirm Password",
                                   isSecureField: true)
                    ValidationFormView(reason: "Match Password",
                                       reasonCheck: registerUser.passwordsMatch)
                }
                VStack {
                    Button(action: {
                        // TODO: Go App
                    }) {
                        Text(isCreateAccount ? "Sign Up": "Sign In")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .frame(width: 150, height: 20, alignment: .center)
                            .padding()
                            .background(registerUserCompleted() ? Color.green : Color.red).animation(.default)
                            .cornerRadius(10)
                    }
                    HStack{
                        Text(isCreateAccount ? "Do you have an Account?" : "New user?")
                            .font(.footnote)
                            .bold()
                        Button(action: {
                            self.isCreateAccount.toggle()
                        }) {
                            Text(isCreateAccount ? "Sign in" : "Sign up")
                                .font(.body)
                                .bold()
                                .foregroundColor(.blue)
                        }
                    }.padding(.top, 8)
                }.padding(.top, 60)
                Spacer()
            }
        }
    }
    
    func registerUserCompleted() -> Bool {
        return registerUser.usernameLengthValid &&
               registerUser.passwordLengthValid &&
               registerUser.passwordUpperLowercassedValid &&
               registerUser.passwordsMatch
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SingleFormView: View {
    
    @Binding var valueUser: String
    var placeholder: String = ""
    var isSecureField: Bool = false
    
    var body: some View {
        VStack{
            if isSecureField {
                SecureField(placeholder, text: $valueUser)
            } else {
                TextField(placeholder, text: $valueUser)
            }
            Divider()
        }.padding()
    }
}

struct ValidationFormView: View {
    
    var reason: String = ""
    var reasonCheck: Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: reasonCheck ? "checkmark.circle" : "xmark.circle")
                .foregroundColor(reasonCheck ? .green : .red)
            Text(reason)
                .font(.footnote)
                .bold()
                .foregroundColor(.gray)
                .strikethrough(reasonCheck)
                .lineLimit(2)
            Spacer()
        }.padding(.horizontal)
    }
}
