//
//  CartViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation

class CartViewModel: ObservableObject {
    
    static let shared = CartViewModel()
    
    private init() { }
    
    @Published var positions = [Position]()
    
    var cost: Int {
        var sum = 0
        for position in positions {
            sum += position.cost
        }
        return sum
    }
    
    func sendOrder(order: Order) {
        DatabaseService.shared.sendOrder(with: order) { result in
            switch result {
            case .success(let order):
                print("Заказ принят в \(order.date)")
                self.positions.removeAll()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
