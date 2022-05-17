//
//  AdminProductsView.swift
//  Appliances
//
//  Created by Кристина Максимова on 14.04.2022.
//

import SwiftUI

struct AdminProductsView: View {
    
    @StateObject var viewModel = AdminProductsViewModel()
    
    
    var body: some View {
        VStack {
            HStack {
                Text("Товары")
                    .font(.title.bold())
                Spacer()
                NavigationLink("+", destination: AddProductView())
                    .font(.custom("AvenirNext-bold", size: 18))
            }.padding(.horizontal)
            List {
                ForEach(viewModel.products, id: \.id) {
                    product in
                    AdminProductCell(product: product)
                        .swipeActions {
                            Button(role: .destructive) {
                                DatabaseService.shared.deleteProduct(by: product.id) {
                                    viewModel.getProducts()
                                }
                            } label: {
                                Text("Удалить")
                            }

                        }
                }
            }
        }
            .onAppear {
                viewModel.getProducts()
            }
    }
}

struct Products_Previews: PreviewProvider {
    static var previews: some View {
        AdminProductsView()
    }
}
