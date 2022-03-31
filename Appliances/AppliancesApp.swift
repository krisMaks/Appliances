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
                TabBarView()
            } else {
            AuthView()
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
