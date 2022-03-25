//
//  ProductViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var count = 0
    
    init(product: Product) {
        self.product = product
    }
}
