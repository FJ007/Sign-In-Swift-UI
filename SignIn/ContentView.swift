//
//  ContentView.swift
//  SignIn
//
//  Created by Javier Fernández on 08/06/2020.
//  Copyright © 2020 Silversun Studio. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack {
            Text("Login")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("Create Your Account")
                .font(.largeTitle)
                .bold()
            
            SingleFormView(valueUser: $username, placeholder: "Username", isSecureField: false)
            ValidationFormView(reason: "It's at least 6 characters.", reasonCheck: true)
            
            SingleFormView(valueUser: $password, placeholder: "Password", isSecureField: true)
            ValidationFormView(reason: "It's at least 8 characters.", reasonCheck: false)
            ValidationFormView(reason: "Make sure including a number, a lowercase and an uppercase letter.", reasonCheck: false)
            
            SingleFormView(valueUser: $confirmPassword, placeholder: "Confirm Password", isSecureField: true)
            ValidationFormView(reason: "Match Password", reasonCheck: false)
            
            VStack {
                Button(action: {
                    // TODO: Next View
                }) {
                    Text("Sign in")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(width: 200, height: 30, alignment: .center)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.blue, .green]),
                                                   startPoint: .trailing,
                                                   endPoint: .leading))
                        .cornerRadius(10)
                }
                HStack{
                    Text("Have an Account?")
                    .font(.footnote)
                    .bold()
                    Button(action: {
                        // TODO: login
                    }) {
                        Text("Sign Up")
                            .font(.body)
                            .bold()
                            .foregroundColor(.blue)
                    }
                }.padding(.top, 8)
            }.padding(.top, 30)
        }
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
