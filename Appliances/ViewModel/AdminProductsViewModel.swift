//
//  AdminProductsViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 14.04.2022.
//

import Foundation

 
class AdminProductsViewModel: ObservableObject {
    @Published var products = [Product]()
    
    func getProducts() {
        DatabaseService.shared.getProducts(filter: .all) { result in
            switch result {
                
            case .success(let products):
                self.products = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
