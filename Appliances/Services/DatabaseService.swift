//
//  DatabaseService.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation
import FirebaseFirestore
import UIKit

class DatabaseService {
    
    static let shared = DatabaseService()
    let db = Firestore.firestore()
    var usersRef: CollectionReference { db.collection("users") }
    var ordersRef: CollectionReference { db.collection("orders") }
    var productsRef: CollectionReference { db.collection("products") }
    
    private init() { }
    
    func getProducts(filter: ProductFilter, completion: @escaping (Result<[Product], Error>) -> ()) {
        productsRef.getDocuments { qSnap, error in
            var products = [Product]()
            if let snap = qSnap {
                for doc in snap.documents {
                    if let product = Product(doc: doc) {
                        switch filter {
                            case .all:
                            products.append(product)
                        
                    case .popular:
                            if product.isPopular {
                                products.append(product)
                            }
                    }
                    }
                }
                completion(.success(products))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func createProduct(_ product: Product,
                       image: UIImage,
                       completion: @escaping (Result<String, Error>) -> ()) {
        productsRef.document(product.id).setData(product.representation) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                StorageService.shared.uploadProductImage(image: image,
                                                         by: product.id) { result in
                    switch result {
                    case .success(let size):
                        print(size)
                        completion(.success(product.id))
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    func getPositions(in order: String,
                      completion: @escaping (Result<[Position], Error>) -> ()) {
        let orderRef = ordersRef.document(order)
        let positionsRef = orderRef.collection("positions")
        
        positionsRef.getDocuments { qSnap, error in
            var positions = [Position]()
            if let qSnap = qSnap {
                for doc in qSnap.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }
                completion(.success(positions))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func getOrders(userID: String?,
                   completion: @escaping (Result<[Order], Error>) -> ()) {
        var orders = [Order]()
        ordersRef.getDocuments { queryDocSnap, error in
            if let error = error {
                completion(.failure(error))
                return
            } else if let queryDocSnap = queryDocSnap {
                for doc in queryDocSnap.documents {
                    guard let order = Order(doc: doc) else { return }
                    if let userID = userID {
                        if userID == order.userID {
                            orders.append(order)
                        }
                    } else {
                        orders.append(order)
                    }
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
    
    func sendPositions(orderID: String,
                       positions: [Position],
                       completion: @escaping (Result<Int, Error>) -> ()) {
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
    
    func getUser(id: String,
                 completion: @escaping (Result<Users, Error>) -> ()) {
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
