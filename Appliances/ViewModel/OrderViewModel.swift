//
//  OrderViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 12.04.2022.
//

import Foundation

class OrderViewModel: ObservableObject {
    @Published var order: Order
    
    
    init(order: Order) {
        self.order = order
    }
    
    func setOrderStatus() {
        DatabaseService.shared.sendOrder(with: self.order) { result in
            switch result {
                
            case .success(let order):
                print("Статус заказа: \(order.status)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
