//
//  OrderCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct OrderCell: View {
    var body: some View {
        HStack(spacing: 24) {
            Text("22.03.2022")
                .font(.custom("AvenirNext-bold", size: 16))
            Spacer()
            Text("890099 ₽")
            Text("Выполнен")
                .foregroundColor(.green)
        }.padding()
    }
}

struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell()
    }
}
