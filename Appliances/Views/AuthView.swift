//
//  ContentView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct AuthView: View {
    
    @State var email = ""
    @State var password = ""
    @State var confirm = ""
    
    @State var isAuth = true
    @State var isTabBarShow = false
    
    var body: some View {
        
        
        VStack  {
            VStack(spacing: 12) {
                Text(isAuth ? "Авторизация" : "Регистрация")
                    .padding()
                    .font(.custom("AvenirNext-bold", size: 26))
                    .foregroundColor(Color("brown"))
                TextField("Email",
                          text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .font(.custom("AvenirNext-regular", size: 20))
                SecureField("Пароль",
                          text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .font(.custom("AvenirNext-regular", size: 20))
                if !isAuth {
                    SecureField("Повторите пароль",
                              text: $confirm)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 4)
                        .font(.custom("AvenirNext-regular", size: 20))
                }
                Button {
                    if isAuth {
                        isTabBarShow.toggle()
                    } else {
                        print("Sign Up")
                        isAuth = true
                    }
                } label: {
                    Text(isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("brown"))
                        .cornerRadius(12)
                        .foregroundColor(Color.white)
                        .font(.custom("AvenirNext-bold", size: 20))
                }
                Button {
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Уже есть аккаунт")
                        .foregroundColor(Color("brown"))
                        .font(.custom("AvenirNext-regular", size: 20))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .padding(.horizontal, isAuth ? 16 : 0)
        }
        .background(
            Image("authBG")
            .blur(radius: isAuth ? 0 : 8))
        .padding()
        .animation(.easeInOut(duration: 0.3),
                   value: isAuth)
        .fullScreenCover(isPresented: $isTabBarShow,
                         onDismiss: nil) {
            TabBarView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
