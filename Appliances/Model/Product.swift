//
//  Product.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation

struct Product {
    var id: String
    var title: String
    var descr: String
    var price: Int
    var isPopular: Bool
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["title"] = title
        repres["descr"] = descr
        repres["price"] = price
        repres["isPopular"] = isPopular
        return repres
    }
}
