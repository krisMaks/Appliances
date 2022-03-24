//
//  CartCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct CartCell: View {
    var body: some View {
        HStack {
            Text("Dyson Animal 18l")
                .font(.custom("AvenirNext-bold", size: 14))
            Spacer()
            VStack(alignment: .center) {
                Text("38 990 ₽")
                Text("1 шт")
            }
            .frame(width: 100)
            .font(.custom("AvenirNext-regular", size: 14))
            Text("78 980 ₽")
                .frame(width: 90)
                .font(.custom("AvenirNext-bold", size: 14))
            
        }
    }
}

struct CartCell_Previews: PreviewProvider {
    static var previews: some View {
        CartCell()
    }
}
