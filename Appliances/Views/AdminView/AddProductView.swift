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
    
    var body: some View {
        VStack {
            Image("authBG")
                .resizable()
                .frame(width: screen.width, height: 200)
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
                    print("Очистить поля")
                } label: {
                    Text("Очистить")
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(12)
                
                Button {
                    print("Создание нового товара")
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
        
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
