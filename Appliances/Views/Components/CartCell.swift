//
//  CartCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct CartCell: View {
    var position: Position
    
    var body: some View {
        HStack {
            Text(position.title)
                .font(.custom("AvenirNext-bold", size: 14))
            Spacer()
            VStack(alignment: .center) {
                Text("\(position.price)")
                Text("\(position.count) шт")
            }
            .frame(width: 100)
            .font(.custom("AvenirNext-regular", size: 14))
            Text("\(position.cost) ₽")
                .frame(width: 90)
                .font(.custom("AvenirNext-bold", size: 14))
            
        }
    }
}
