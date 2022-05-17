//
//  AdminOrdersViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 14.04.2022.
//

import Foundation


class AdminOrdersViewModel: ObservableObject {
    @Published var orders = [Order]()
    
    func getOrders(completion: @escaping () -> ()) {
        DatabaseService.shared.getOrders(userID: nil) { result in
            switch result {
                
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPositions(in: order.id) { result in
                        switch result {
                            
                        case .success(let positions):
                            self.orders[index].positions = positions
                            completion()
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
