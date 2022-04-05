//
//  ProfileView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct ProfileView: View {
    
    var order = [String]()
    @Environment (\.dismiss) var dismiss
    @State var isShowActionSheet = false
    @State var isShowImagePickerAlert = false
    @State private var isShowPicker = false
    @State private var source: ImagePickerSourceType = .gallery
    @State private var profilePicture: UIImage? = UIImage(systemName: "person.circle")
    @State var isFromAuth = false
    @State private var showAuthScreen = false
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: profilePicture!)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .cornerRadius(45)
                        .padding(6)
                        .onTapGesture {
                            isShowImagePickerAlert.toggle()
                        }
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Введите имя:", text: $viewModel.user.name)
                            .font(.custom("AvenirNext-bold", size: 22))
                        HStack {
                            Text("+7")
                                .font(.custom("AvenirNext-regular", size: 20))
                            TextField("Введите номер телефона:", text: $viewModel.phone)
                                .font(.custom("AvenirNext-regular", size: 20))
                                .keyboardType(.numberPad)
                        }
                    }
                    Spacer()
                }
                Text("Адрес доставки:")
                    .padding(.horizontal, 6)
                    .font(.custom("AvenirNext-bold", size: 16))
                TextField("Введите Ваш адрес:", text: $viewModel.user.address)
                    .padding(.horizontal, 6)
                    .font(.custom("AvenirNext-regular", size: 14))
                
                if self.order.isEmpty {
                    Text("Сдесь будут Ваша заказы")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .center)
                        .background(Color("veryLightGray"))
                        .foregroundColor(.gray)
                } else {
                    List {
                        OrderCell()
                    }.listStyle(.plain)
                }
                
            }.padding(10)
            Button {
                isShowActionSheet.toggle()
            } label: {
                Text("Выход")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 40)
                    .background(Color.red)
                    .font(.custom("AvenirNext-bold", size: 16))
                    .cornerRadius(12)
            }
        }
        .onSubmit {
            if let phone = Int(viewModel.phone) {
                if viewModel.phone.count == 10 {
                    viewModel.user.phone = phone
                }
            }
            
            DatabaseService.shared.setUser(user: viewModel.user) { result in
                switch result {
                case .success(let user):
                    print(user)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        .confirmationDialog("Внимание!", isPresented: $isShowActionSheet, titleVisibility: .visible) {
            Button(role: .destructive) {
                AuthService.shared.signOut {
                    if isFromAuth {
                        dismiss()
                    } else {
                        showAuthScreen.toggle()
                    }
                }
            } label: {
                Text("Да")
            }
            Button(role: .cancel) { } label: {
                Text("Нет")
            }


        } message: {
            Text("Вы действительно хотите выйти?")
        }
        .fullScreenCover(isPresented: $showAuthScreen, content: {
            AuthView()
        })
        .confirmationDialog("Откуда взять картинку?", isPresented: $isShowImagePickerAlert, titleVisibility: .visible) {
            Button {
                source = .camera
                isShowPicker.toggle()
            } label: {
                Text("Камера")
            }
            
            Button {
                source = .gallery
                isShowPicker.toggle()
            } label: {
                Text("Галерея")
            }
            
            Button(role: .cancel) { } label: {
                Text("Отмена")
            }
        }
        .onAppear {
            DatabaseService.shared.getUser(id: AuthService.shared.currentUser!.uid) { result in
                switch result {
                    
                case .success(let user):
                    viewModel.user = user
                    viewModel.phone = "\(user.phone)"
                case .failure(let error):
                    print("Ошибка получения данных профиля \(error.localizedDescription)")
                }
            }
        }
        .sheet(isPresented: $isShowPicker) {
            ImagePicker(sourceType: self.source == .camera ? .camera : .photoLibrary,
                        selectedImage: $profilePicture)
                
                .onDisappear {
                    print("Сохранение в храниище")
                }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProfileViewModel(user: Users(id: "", name: "", phone: 890011, address: ""))
        ProfileView(viewModel: viewModel)
    }
}
