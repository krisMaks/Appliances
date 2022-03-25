//
//  Position.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation

struct Position: Identifiable {
    var id: String
    var product: Product
    var count: Int
    
    var cost: Int {
        return product.price * count
    }
}
