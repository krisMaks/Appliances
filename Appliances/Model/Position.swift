//
//  Position.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import Foundation
import FirebaseFirestore

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
    
    internal init(id: String, count: Int, title: String, price: Int) {
        self.id = id
        self.count = count
        self.title = title
        self.price = price
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()
        
        guard let id = data["id"] as? String else { return nil }
        guard let count = data["count"] as? Int else { return nil }
        guard let title = data["title"] as? String else { return nil }
        guard let price = data["price"] as? Int else { return nil }
        
        self.id = id
        self.count = count
        self.title = title
        self.price = price
    }
}
