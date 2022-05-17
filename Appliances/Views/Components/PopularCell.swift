//
//  PopularCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct PopularCell: View {
    
    let product: Product
    @State var image = UIImage(systemName: "bonjour")
    
    var body: some View {
        VStack {
            Image(uiImage: image!)
                .resizable(resizingMode: .stretch)
                .frame(width: 80,
                       height: 80)
                .cornerRadius(40)
            Text(product.title)
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .frame(width: 120)
        }.padding(5)
            .onAppear {
                StorageService.shared.downloadProductImage(by: product.id) { result in
                    switch result {
                    case .success(let data):
                        guard let image = UIImage(data: data) else { return }
                        self.image = image
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}


