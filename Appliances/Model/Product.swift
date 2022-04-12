//
//  Product.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation
import FirebaseFirestore

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
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let descr = data["descr"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        guard let isPopular = data["isPopular"] as? Bool else { return nil }
        
        self.id = id
        self.title = title
        self.descr = descr
        self.price = price
        self.isPopular = isPopular
    }
    
    internal init(id: String, title: String, descr: String, price: Int, isPopular: Bool) {
        self.id = id
        self.title = title
        self.descr = descr
        self.price = price
        self.isPopular = isPopular
    }
}
