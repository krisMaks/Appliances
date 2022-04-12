//
//  CatalogView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct CatalogView: View {
    @State private var isDetailPresented = false
    @StateObject var viewModel: CatalogViewModel
    
    let layoutForMain = [GridItem(.adaptive(minimum: screen.width / 2.0), spacing: 0)]
    let layoutForPopular = [GridItem(.fixed(180),
                                    spacing: 0)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular,
                              spacing: 20) {
                        ForEach(viewModel.popularProducts,
                                id: \.id) { item in
                            PopularCell(product: item)
                                .onTapGesture {
                                    viewModel.currentProduct = item
                                    isDetailPresented.toggle()
                                }
                        }
                    }
                }
            }
            
            Section("Каталог") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForMain,
                              spacing: 20) {
                        ForEach(viewModel.products,
                                id: \.id) { item in
                            ProductCell(product: item)
                                .onTapGesture {
                                    viewModel.currentProduct = item
                                    isDetailPresented.toggle()
                                }
                        }
                        
                    }
                }
            }
        }.sheet(isPresented: $isDetailPresented) {
            let product = viewModel.currentProduct
            
            ProductView(viewModel: ProductViewModel(product: product))
        }
        .onAppear {
            viewModel.getProducts()
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView(viewModel: CatalogViewModel())
    }
}
