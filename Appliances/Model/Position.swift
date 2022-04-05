//
//  Position.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation

struct Position: Identifiable {
    var id: String
    var count: Int
    var title: String
    var price: Int
    
    var cost: Int {
        return price * count
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["count"] = count
        repres["title"] = title
        repres["price"] = price
        return repres
    }
}
