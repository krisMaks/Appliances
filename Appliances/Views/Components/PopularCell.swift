//
//  PopularCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct PopularCell: View {
    
    let product: Product
    
    var body: some View {
        VStack {
            Image("authBG")
                .resizable(resizingMode: .stretch)
                .frame(width: 80,
                       height: 80)
                .cornerRadius(40)
            Text(product.title)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .frame(width: 120)
        }.padding(5)
    }
}


