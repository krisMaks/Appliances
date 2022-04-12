//
//  AddProductView.swift
//  Appliances
//
//  Created by Кристина Максимова on 08.04.2022.
//

import SwiftUI

struct AddProductView: View {
    
    @State var title: String = ""
    @State var price = 90
    @State var descript: String = ""
    @State var isPopular = false
    @State var image: UIImage? = UIImage(named: "authBG")!
    @State var isShowImagePickerAlert = false
    @State var isShowPicker = false
    @State private var source: ImagePickerSourceType = .gallery
    
    var body: some View {
        VStack {
            Image(uiImage: image!)
                .resizable()
                .frame(width: screen.width, height: 200)
                .onTapGesture {
                    isShowImagePickerAlert.toggle()
                }
            TextField("Название", text: $title)
                .padding()
            TextField("Цена", value: $price, formatter: NumberFormatter())
                .padding()
            TextField("Описание", text: $descript)
                .padding()
            
            
                Toggle(isOn: $isPopular) {
                    Text("Популярный?")
                }
            HStack {
                Button {
                    title = ""
                    price = 0
                    descript = ""
                } label: {
                    Text("Очистить")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                Button {
                    print("Создание нового товара")
                    let product = Product(id: UUID().uuidString, title: title, descr: descript, price: price, isPopular: isPopular)
                    DatabaseService.shared.createProduct(product, image: image!) { result in
                        switch result {
                            
                        case .success(let value):
                            print(value)
                            title = ""
                            price = 0
                            descript = ""
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    
                } label: {
                    Text("Создать")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            
            
        }
        .padding()
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
        .sheet(isPresented: $isShowPicker) {
            ImagePicker(sourceType: self.source == .camera ? .camera : .photoLibrary,
                        selectedImage: $image)
            
        }
//        .onAppear {
//            AuthService.shared.signOut {
//                print("singOUT")
//            }
//        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
