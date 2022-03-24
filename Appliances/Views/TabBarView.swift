//
//  TabBarView.swift
//  Appliances
//
//  Created by Кристина Максимова on 18.03.2022.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            CatalogView()
                .tabItem {
                    VStack {
                        Image(systemName: "menucard")
                        Text("Каталог")
                    }
                }
            CartView()
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Корзина")
                    }
                }
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person.circle")
                        Text("Профиль")
                    }
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
