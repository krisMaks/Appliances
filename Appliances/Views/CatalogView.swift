//
//  CatalogView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct CatalogView: View {
    @State private var isDetailPresented = false
    
    let layoutForMain = [GridItem(.adaptive(minimum: screen.width / 2.0), spacing: 0)]
    let layoutForPopular = [GridItem(.fixed(180),
                                    spacing: 0)]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular,
                              spacing: 20) {
                        PopularCell()
                        PopularCell()
                        PopularCell()
                        PopularCell()
                        PopularCell()
                        PopularCell()
                    }
                }
            }
            
            Section("Каталог") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForMain,
                              spacing: 20) {
                        ProductCell()
                            .onTapGesture {
                                isDetailPresented.toggle()
                            }
                        ProductCell()
                        ProductCell()
                        ProductCell()
                        ProductCell()
                        ProductCell()
                        ProductCell()
                        ProductCell()
                    }
                }
            }
        }.sheet(isPresented: $isDetailPresented) {
            ProductView()
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
