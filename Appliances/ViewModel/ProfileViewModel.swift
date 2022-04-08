//
//  ProfileViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation
import UIKit


class ProfileViewModel: ObservableObject {
    @Published var user: Users
    @Published var phone: String = "0"
    @Published var orders = [Order]()
    @Published var profilePicture: UIImage? = UIImage(systemName: "person.circle")
    
    init(user: Users) {
        self.user = user
    }
    
    func downloadAvatar() {
        StorageService.shared.downloadAvatar { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                self.profilePicture = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile() {
        DatabaseService.shared.getUser(id: AuthService.shared.currentUser!.uid) { result in
            switch result {
                
            case .success(let user):
                self.user = user
                self.phone = "\(user.phone)"
                self.downloadAvatar()
                DatabaseService.shared.getOrders(userID: user.id) { result in
                    switch result {
                    case .success(let orders):
                        self.orders = orders
                        
                        for (index, order) in self.orders.enumerated() {
                            DatabaseService.shared.getPositions(in: order.id) { result in
                                switch result {
                                case .success(let positions):
                                    self.orders[index].positions = positions
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print("Ошибка получения данных профиля \(error.localizedDescription)")
            }
        }
    }
    
    func setUser() {
        DatabaseService.shared.setUser(user: self.user) { result in
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func upload(avatar: UIImage) {
        StorageService.shared.upload(photo: avatar) { result in
            switch result {
            case .success(let size):
                print(size)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
