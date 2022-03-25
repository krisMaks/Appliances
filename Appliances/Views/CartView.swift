//
//  CartView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct CartView: View {
    
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Корзина")
                    .font(.custom("AvenirNext-bold", size: 26))
                Spacer()
            }.padding()
            List(viewModel.positions) { position in
                CartCell(position: position)
                    .swipeActions {
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id && pos.cost == position.cost
                            }
                        } label: {
                            Text("Удалить")
                        }.tint(.red)
                    }
            }.listStyle(.plain)
            HStack {
                Text("Итого:")
                    .font(.custom("AvenirNext-bold", size: 16))
                Spacer()
                Text("\(viewModel.cost) ₽")
                    .font(.custom("AvenirNext-bold", size: 16))
            }.padding()
            
            HStack(spacing: 34) {
                Button {
                    print("Clear")
                    viewModel.positions.removeAll()
                } label: {
                    Text("Очистить")
                        .frame(width: 120,
                               height: 50,
                               alignment: .center)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
              
                Button {
                    print("Заказать")
                } label: {
                    Text("Заказать")
                        .frame(maxWidth: .infinity,
                               maxHeight: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }.padding(16)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
