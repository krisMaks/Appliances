//
//  AppliancesApp.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI
import Firebase

@main
struct AppliancesApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            if let _ = AuthService.shared.currentUser {
//                DatabaseService.shared.getUser(id: user.uid) { result in
//                    switch result {
//                    case .success(let user):
//                        TabBarView()
//                    case .failure(let error):
//                        AuthView()
//                    }
//                }
                TabBarView()
                    .preferredColorScheme(.light)
            } else {
            AuthView()
                    .preferredColorScheme(.light)
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
let screen = UIScreen.main.bounds
