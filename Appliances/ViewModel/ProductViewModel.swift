//
//  ProductViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation
import UIKit

class ProductViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var count = 1
    @Published var image = UIImage(systemName: "ant")!
    
    init(product: Product) {
        self.product = product
    }
    
    func getImage() {
        StorageService.shared.downloadProductImage(by: product.id) { result in
            switch result {
                
            case .success(let image):
                guard let image = UIImage(data: image) else { return }
                self.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
