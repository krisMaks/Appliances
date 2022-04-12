//
//  CatalogViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 25.03.2022.
//

import Foundation
import UIKit

class CatalogViewModel: ObservableObject {
    
    @Published var currentProduct = Product(id: "1",
                                            title: "Блендер",
                                            descr: "Хорошенький",
                                            price: 40990,
                                            isPopular: false)
    
    @Published var popularProducts = [Product]()
    @Published var products = [Product]()
    @Published var images = [String: UIImage]()
    
    func getProducts() {
        DatabaseService.shared.getProducts(filter: .all) { result in
            switch result {
            case .success(let products):
                self.products = products
                for product in products {
                    if product.isPopular { self.popularProducts.append(product) }                    
                    }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    
}
