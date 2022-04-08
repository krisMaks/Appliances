//
//  OrderCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct OrderCell: View {
    
    var order: Order
    
    var body: some View {
        HStack(spacing: 24) {
            Text("\(order.date)")
                .font(.custom("AvenirNext-bold", size: 16))
            Spacer()
            Text("\(order.cost) ₽")
            Text("\(order.status)")
                .foregroundColor(.green)
        }.padding()
    }
}

struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell(order: Order(id: "12345",
                               userID: "sdd",
                               date: Date()))
    }
}
