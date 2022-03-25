//
//  CatalogViewModel.swift
//  Appliances
//
//  Created by Кристина Максимова on 25.03.2022.
//

import Foundation


class CatalogViewModel: ObservableObject {
    
    @Published var currentProduct = Product(id: "1",
                                            title: "Блендер",
                                            descr: "Хорошенький",
                                            price: 40990,
                                            isPopular: false)
    
    var popularProducts: [Product] = [Product(id: "1",
                                              title: "Блендер Pixel-Void 10900",
                                              descr: "Хорошенький",
                                              price: 40990,
                                              isPopular: false),
                                      Product(id: "2",
                                                            title: "Кофеварка Dyson-TY800",
                                                            descr: "Нормально",
                                                            price: 1599,
                                                            isPopular: false),
                                      Product(id: "3",
                                                            title: "Утюг Philips-AnyKey1200",
                                                            descr: "Пойдет",
                                                            price: 17990,
                                                            isPopular: false)]
    var products: [Product] = [Product(id: "1",
                                       title: "Блендер",
                                       descr: "Хорошенький",
                                       price: 40990,
                                       isPopular: false),
                               Product(id: "2",
                                                     title: "Кофеварка",
                                                     descr: "Нормально",
                                                     price: 1599,
                                                     isPopular: false),
                               Product(id: "3",
                                                     title: "Утюг",
                                                     descr: "Пойдет",
                                                     price: 17990,
                                                     isPopular: false)]
}
