//
//  HomeViewModel.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 13.09.2022.
//

import Combine

class HomeViewModel: ObservableObject {

    @Published var productType: ProductType = .wearable

    private var cancellables = Set<AnyCancellable>()

    // Sample Products...
    private var products: [Product] = [
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series 6: Red", price: "$359",productImage: "AppleWatch6"),
        Product(type: .wearable, title: "Samsung Watch", subtitle: "Gear: Black", price: "$180", productImage: "SamsungWatch"),
        Product(type: .wearable, title: "Apple Watch", subtitle: "Series 4: Black", price: "$250", productImage: "AppleWatch4"),
        Product(type: .phones, title: "iPhone 13", subtitle: "A15 - Pink", price: "$699", productImage: "iPhone13"),
        Product(type: .phones, title: "iPhone 12", subtitle: "A14 - Blue", price: "$599", productImage: "iPhone12"),
        Product(type: .phones, title: "iPhone 11", subtitle: "A13 - Purple", price: "$499", productImage: "iPhone11"),
        Product(type: .phones, title: "iPhone SE 2", subtitle: "A13 - White", price: "$399", productImage: "iPhoneSE"),
        Product(type: .laptops, title: "MacBook Air", subtitle: "M1 - Gold", price: "$999", productImage: "MacBookAir"),
        Product(type: .laptops, title: "MacBook Pro", subtitle: "M1 - Space Grey", price: "$1299", productImage: "MacBookPro"),
        Product(type: .tablets, title: "iPad Pro", subtitle: "M1 - Silver", price: "$999", productImage: "iPadPro"),
        Product(type: .tablets, title: "iPad Air 4", subtitle: "A14 - Pink", price: "$699", productImage: "iPadAir"),
        Product(type: .tablets, title: "iPad Mini", subtitle: "A15 - Grey", price: "$599", productImage: "iPadMini"),
        Product(type: .laptops, title: "iMac", subtitle: "M1 - Purple", price: "$1599", productImage: "iMac"),
    ]

    @Published var filteredProducts: [Product] = []

    init() {
        filterProductByType()
    }

     func filterProductByType() {
        $productType.sink { [weak self] productType in
            guard let self = self else {
                return
            }
            self.filteredProducts = self.products
                .lazy
                .filter { $0.type == productType }
                .prefix(4)
                .compactMap({ $0 })
        }.store(in: &cancellables)
    }
}
