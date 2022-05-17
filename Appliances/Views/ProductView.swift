//
//  ProductView.swift
//  Appliances
//
//  Created by Кристина Максимова on 24.03.2022.
//

import SwiftUI

struct ProductView: View {
    
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel: ProductViewModel
    
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(maxWidth: 250, maxHeight: 250)
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.product.title)
                        .font(.custom("AvenirNext-bold", size: 22))
                    Text("\(viewModel.product.price) ₽")
                        .font(.custom("AvenirNext-regular", size: 20))
                    Text(viewModel.product.descr)
                        .font(.custom("AvenirNext-regular", size: 16))
                }.padding(.horizontal)
                Spacer()
            }
            
            HStack {
                Stepper("Количество",
                        value: $viewModel.count,
                        in: 1...10)
                Text("\(viewModel.count)")
                    .padding(.leading, 30)
            }.padding()
            Button {
                print("В корзину")
                let product = Product(id: viewModel.product.id,
                                      title: viewModel.product.title,
                                      descr: viewModel.product.descr,
                                      price: viewModel.product.price,
                                      isPopular: false)
                let position = Position(id: UUID().uuidString, 
                                        count: viewModel.count,
                                        title: product.title,
                                        price: product.price)
                CartViewModel.shared.positions.append(position)
                dismiss()
            } label: {
                Text("В корзину")
                    .font(.custom("AvenirNext-regular", size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 40)
                    .background(Color.green)
                    .cornerRadius(12)
                    .padding()
            }
            Spacer()
                .onAppear {
                    viewModel.getImage()
                }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ProductViewModel(product: Product(id: "1",
                                                          title: "Блендер",
                                                          descr: "Хорошенький",
                                                          price: 40990,
                                                          isPopular: false))
        ProductView(viewModel: viewModel)
    }
}
