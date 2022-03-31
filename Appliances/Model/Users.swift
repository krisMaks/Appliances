//
//  Users.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation


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
}
