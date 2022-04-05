//
//  ProfileViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 31.03.2022.
//

import Foundation


class ProfileViewModel: ObservableObject {
    @Published var user: Users
    @Published var phone: String = "0"
    
    init(user: Users) {
        self.user = user
    }
}
