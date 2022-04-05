//
//  Order.swift
//  Appliances
//
//  Created by Кристина Максимова on 05.04.2022.
//

import Foundation
import FirebaseFirestore

enum OrderStatus: String {
    case new = "Новый"
    case cooking = "Готовится"
    case delivery = "Доставляется"
    case cancelled = "Отменен"
    case completed = "Выполнен"
}


struct Order {
    
    var id: String = UUID().uuidString
    var positions: [Position] = []
    var userID: String
    var date: Date
    var status: String = OrderStatus.new.rawValue
    
    var cost: Int {
        var sum = 0
        for position in positions {
            sum += position.cost
        }
        return sum
    }
    
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date)
        repres["status"] = status
        return repres
    }
    
    internal init(id: String = UUID().uuidString,
                  positions: [Position] = [Position](),
                  userID: String,
                  date: Date) {
        self.id = id
        self.userID = userID
        self.date = date
    }
    
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data() 
        guard let id = data["id"] as? String else { return nil }
        guard let userID = data["userID"] as? String else { return nil }
        guard let date = data["date"] as? Timestamp else { return nil }
        guard let status = data["status"] as? String else { return nil }
        
        self.id = id
        self.userID = userID
        self.date = date.dateValue()
        self.status = status
    }
    
    init?(doc: DocumentSnapshot) {
        guard let data = doc.data() else { return nil }
        guard let id = data["id"] as? String else { return nil }
        guard let userID = data["userID"] as? String else { return nil }
        guard let date = data["date"] as? Timestamp else { return nil }
        guard let status = data["status"] as? String else { return nil }
        
        self.id = id
        self.userID = userID
        self.date = date.dateValue()
        self.status = status
    }
    
    
}
