//
//  ProfileView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct ProfileView: View {
    
    var order = [String]()
    @State var name = "Вася Курочкин"
    @State var phone = "9819888998"
    @State var address = "Москва, Москоская область, Ленинградский район, улица Любимова, дом 17, корпус 12, литерал А, квартира 189, 123456"
    @Environment (\.dismiss) var dismiss
    @State var isShowActionSheet = false
    @State var isShowImagePickerAlert = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .padding(6)
                        .onTapGesture {
                            isShowImagePickerAlert.toggle()
                        }
                    VStack(alignment: .leading, spacing: 6) {
                        TextField("Введите имя:", text: $name)
                            .font(.custom("AvenirNext-bold", size: 22))
                        HStack {
                            Text("+7")
                                .font(.custom("AvenirNext-regular", size: 20))
                            TextField("Введите номер телефона:", text: $phone)
                                .font(.custom("AvenirNext-regular", size: 20))
                                .keyboardType(.numberPad)
                        }
                    }
                    Spacer()
                }
                Text("Адрес доставки:")
                    .padding(.horizontal, 6)
                    .font(.custom("AvenirNext-bold", size: 16))
                TextField("Введите Ваш адрес:", text: $address)
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
        .confirmationDialog("Внимание!", isPresented: $isShowActionSheet, titleVisibility: .visible) {
            Button(role: .destructive) {
                dismiss()
            } label: {
                Text("Да")
            }
            Button(role: .cancel) { } label: {
                Text("Нет")
            }


        } message: {
            Text("Вы действительно хотите выйти?")
        }
        
        .confirmationDialog("Откуда взять картинку?", isPresented: $isShowImagePickerAlert, titleVisibility: .visible) {
            Button {
                
            } label: {
                Text("Камера")
            }
            
            Button {
                
            } label: {
                Text("Галерея")
            }
            
            Button(role: .cancel) { } label: {
                Text("Отмена")
            }
        } 
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
