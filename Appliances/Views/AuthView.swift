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
    @State var message = ""
    @State var isAlertShow = false
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
                        AuthService.shared.signIn(email: email,
                                                  password: password) { result in
                            switch result {
                            case .success(_):
                                isTabBarShow.toggle()
                            case .failure(let error):
                                message = "Ошибка авторизации \(error.localizedDescription)"
                                isAlertShow.toggle()
                            }
                        }
                        
                    } else {
                        guard password == confirm else {
                            message = "Пароли не совпадают"
                            isAlertShow.toggle()
                            return
                        }
                        AuthService.shared.signUp(email: email,
                                                  password: password) { result in
                            switch result {
                            case .success(let user):
                                if let email = user.email {
                                    message = "Успешно! Пользователь \(email) зарегистрирован"
                                }
                                isAlertShow.toggle()
                                email = ""
                                password = ""
                                confirm = ""
                                isAuth = true
                            case .failure(let error):
                                message = "Войти не удалось. Ошибка \(error.localizedDescription)"
                            }
                        }
                        
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
                         .alert(message,
                                isPresented: $isAlertShow) {
                             Text("OK")
                         }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
