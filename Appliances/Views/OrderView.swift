//
//  OrderView.swift
//  Appliances
//
//  Created by Кристина Максимова on 12.04.2022.
//

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel: OrderViewModel
    var status = ["Новый", "Готовится", "Доставляется", "Отменен", "Выполнен"]
    @State var selection = ""
    
    var body: some View {
        VStack {
            Text("Заказ № \(viewModel.order.id)")
            List(viewModel.order.positions, id: \.id) { position in
                CartCell(position: position)
            }.listStyle(.plain)
            
            if AuthService.shared.isAdmin {
                Picker("Статус заказа", selection: $selection) {
                    ForEach(status, id: \.self) {
                        Text($0)
                    }
                    
                }.pickerStyle(.wheel)
                Button {
                    viewModel.order.status = selection
                    viewModel.setOrderStatus()
                } label: {
                    Text("Сохранить")
                }

            }
                
            
            HStack {
                Text("Итого:")
                    .font(.custom("AvenirNext-bold", size: 16))
                Spacer()
                Text("\(viewModel.order.cost) ₽")
                    .font(.custom("AvenirNext-bold", size: 16))
            }.padding()
        }.padding()
            .onAppear {
                self.selection = viewModel.order.status
            }
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(viewModel: OrderViewModel(order: Order(userID: "", date: Date())))
    }
}
