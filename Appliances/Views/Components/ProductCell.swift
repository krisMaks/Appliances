//
//  ProductCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct ProductCell: View {
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image("authBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45, maxHeight: screen.width * 0.5)
                
            Text("Dyson Moto moto")
                .font(.custom("AvenirNext-regular", size: 14))
                .padding(.horizontal, 6)
            Text("360099 ₽")
                .font(.custom("AvenirNext-bold", size: 16))
                .padding(.horizontal, 6)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(5)
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell()
    }
}
