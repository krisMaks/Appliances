//
//  AdminOrdersView.swift
//  Appliances
//
//  Created by Кристина Максимова on 14.04.2022.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject var viewModel = AdminOrdersViewModel()
    @State private var isShowAddProductView = false
    @State private var isShowAuthView = false
    @State private var isShowOrderView = false
    @State var currentOrder = Order(userID: "", date: Date())
    @State var canShowOrderView = false
    
    
    var body: some View {
        NavigationView {
        VStack {
            HStack {
                Text("Заказы")
                    .font(.title.bold())
                Spacer()
                
                NavigationLink("Добавить товар", destination: AdminProductsView()) 
                
//                Button {
//                    isShowAddProductView.toggle()
//                } label: {
//                    Text("Добавить товар")
//                }

            }
                .onAppear {
                    viewModel.getOrders {
                        canShowOrderView = true
                    }
                }
                
            List {
                ForEach(viewModel.orders, id: \.id) { order in
                OrderCell(order: order)
                        .onTapGesture {
                            self.currentOrder = order
                            isShowOrderView.toggle()
                        }
            }
            }.listStyle(.plain)
            Button {
                AuthService.shared.signOut {
                    isShowAuthView.toggle()
                }
            } label: {
                Text("Выйти")
                    .padding()
                    .frame(width: 150)
                    .background(Color.red)
                    .cornerRadius(12)
                    .foregroundColor(Color.white)
            }
            .sheet(isPresented: $isShowOrderView) {
                if canShowOrderView {
                    OrderView(viewModel: OrderViewModel(order: currentOrder))
                }
            }
            .fullScreenCover(isPresented: $isShowAuthView) {
                AuthView()
            }
            .navigationBarHidden(true)

        }.padding()
        }
            
    }
        
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
