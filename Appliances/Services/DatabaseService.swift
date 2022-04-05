//
//  DatabaseService.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    static let shared = DatabaseService()
    let db = Firestore.firestore()
    var usersRef: CollectionReference { db.collection("users") }
    var ordersRef: CollectionReference { db.collection("orders") }
    
    private init() { }
    
    func getOrders(userID: String, completion: @escaping (Result<[Order], Error>) -> ()) {
        var orders = [Order]()
        ordersRef.getDocuments { queryDocSnap, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let queryDocSnap = queryDocSnap {
                for doc in queryDocSnap.documents {
                    guard let order = Order(doc: doc) else { return }
                    orders.append(order)
                }
                completion(.success(orders))
            }
        }
    }
    
    func sendOrder(with order: Order,
                   completion: @escaping (Result<Order, Error>) -> ()) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.sendPositions(orderID: order.id,
                              positions: order.positions) { result in
                    switch result {
                        
                    case .success(_):
                        completion(.success(order))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func sendPositions(orderID: String, positions: [Position], completion: @escaping (Result<Int, Error>) -> ()) {
        let positionRef = ordersRef.document(orderID).collection("positions")
        for position in positions {
            positionRef.document(position.id).setData(position.representation) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(positions.count))
                }
            }
        }
    }
    
    func setUser(user: Users,
                   completion: @escaping (Result<Users, Error>) -> ()) {
        usersRef.document(user.id).setData(user.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
    
    func getUser(id: String, completion: @escaping (Result<Users, Error>) -> ()) {
        let docRef = usersRef.document(id)
        docRef.getDocument { docSnap, error in
            if let docSnap = docSnap, docSnap.exists {
                guard let user = Users(doc: docSnap) else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(user))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
