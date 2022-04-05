//
//  Users.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation
import FirebaseFirestore


struct Users {
    
    
    var id: String
    var name: String
    var phone: Int
    var address: String
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["name"] = name
        repres["phone"] = phone
        repres["address"] = address
        return repres
    }
    
    internal init(id: String, name: String, phone: Int, address: String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
    }
    
    init?(doc: DocumentSnapshot) {
        guard let data = doc.data() else { return nil }
        guard let id = data["id"] as? String else { return nil }
        guard let name = data["name"] as? String else { return nil }
        guard let phone = data["phone"] as? Int else { return nil }
        guard let address = data["address"] as? String else { return nil }
        
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
    }
}
