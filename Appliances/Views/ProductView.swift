//
//  ProductView.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import SwiftUI

struct ProductView: View {
    @State var count = 1
    @Environment (\.dismiss) var dismiss
    var body: some View {
        VStack {
            Image("authBG")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 250)
                .aspectRatio(1, contentMode: .fit)
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Dyson VB-1600")
                        .font(.custom("AvenirNext-bold", size: 22))
                    Text("678 000 ₽")
                        .font(.custom("AvenirNext-regular", size: 20))
                    Text("Description")
                        .font(.custom("AvenirNext-regular", size: 16))

                    
                }.padding(.horizontal)
                Spacer()
            }
            
            HStack {
                Stepper("Количество",
                        value: $count,
                        in: 1...10)
                Text("\(self.count)")
                    .padding(.leading, 30)
            }.padding()
            Button {
                print("В корзину")
                dismiss()
            } label: {
                Text("В корзину")
                    .font(.custom("AvenirNext-regular", size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 40)
                    .background(Color.green)
                    .cornerRadius(12)
                    .padding()
            }
            Spacer()
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
