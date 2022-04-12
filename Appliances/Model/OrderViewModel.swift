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
}
