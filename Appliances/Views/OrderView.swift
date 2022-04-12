//
//  OrderView.swift
//  Appliances
//
//  Created by Кристина Максимова on 12.04.2022.
//

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel: OrderViewModel
    var body: some View {
        VStack {
            Text("Заказ № \(viewModel.order.id)")
            List(viewModel.order.positions, id: \.id) { position in
                CartCell(position: position)
            }.listStyle(.plain)
            HStack {
                Text("Итого:")
                    .font(.custom("AvenirNext-bold", size: 16))
                Spacer()
                Text("\(viewModel.order.cost) ₽")
                    .font(.custom("AvenirNext-bold", size: 16))
            }.padding()
        }.padding()
        
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(viewModel: OrderViewModel(order: Order(userID: "", date: Date())))
    }
}
