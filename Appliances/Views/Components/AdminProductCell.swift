//
//  AdminProductCell.swift
//  Appliances
//
//  Created by Кристина Максимова on 14.04.2022.
//

import SwiftUI

struct AdminProductCell: View {
    
    var product: Product
    @State var image = UIImage(systemName: "bonjour")
    
    var body: some View {
        HStack {
            Image(uiImage: image!)
                .resizable()
                .frame(width: 60, height: 60)
            
            Text(product.title)
                .padding()
            Spacer()
            Text("\(product.price) ₽")
        }.padding(.horizontal)
            .padding(.vertical, 4)
            .onAppear {
                StorageService.shared.downloadProductImage(by: product.id) { result in
                    switch result {
                        
                    case .success(let data):
                        self.image = UIImage(data: data)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct AdminProductCell_Previews: PreviewProvider {
    static var previews: some View {
        AdminProductCell(product: Product(id: "", title: "", descr: "", price: 100, isPopular: false))
    }
}
