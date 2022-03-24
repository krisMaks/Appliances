//
//  PopularCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct PopularCell: View {
    var body: some View {
        VStack {
            Image("authBG")
                .resizable(resizingMode: .stretch)
                .frame(width: 80,
                       height: 80)
                .cornerRadius(40)
            Text("Panasonic\nc4500")
                .multilineTextAlignment(.center)
        }.padding(5)
    }
}

struct PopularCell_Previews: PreviewProvider {
    static var previews: some View {
        PopularCell()
    }
}
