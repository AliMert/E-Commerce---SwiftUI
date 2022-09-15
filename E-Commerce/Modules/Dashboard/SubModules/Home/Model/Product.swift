//
//  Product.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 13.09.2022.
//

import Foundation

struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var subtitle: String
    var description: String = ""
    var price: String
    var productImage: String = ""
    var quantity: Int = 1
}
