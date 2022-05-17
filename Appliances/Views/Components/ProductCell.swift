//
//  ProductCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 22.03.2022.
//

import SwiftUI

struct ProductCell: View {
    
    let product: Product
    @State var image = UIImage(systemName: "bonjour")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(uiImage: image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: screen.width * 0.45, maxHeight: screen.width * 0.5)
                
            Text(product.title)
                .font(.custom("AvenirNext-regular", size: 14))
                .padding(.horizontal, 6)
            Text("\(product.price) ₽")
                .font(.custom("AvenirNext-bold", size: 16))
                .padding(.horizontal, 6)
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 2)
        .padding(5)
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
