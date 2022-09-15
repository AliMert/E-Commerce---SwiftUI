//
//  HomeView.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 13.09.2022.
//

import SwiftUI

struct HomeView: View {
    @Namespace private var animation
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {

            VStack(spacing: 15) {
                SearchBar()
                    .frame(width: getRect().width / 1.6)
                    .padding(.horizontal, 25)

                Text("Order online\ncollect in store")
                    .foregroundColor(Color.black)
                    .font(.custom(Raleway.bold, size: 28))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal, 25)

                ProductsTabView()
                    .padding(.vertical, 20)

                // Products Page
                ProductsPageView()
                    .animation(nil, value: UUID())

            }
            .padding(.vertical)
        }
        .maxWidthAndHeight()
        .background(Color("HomeBG"))
    }

    @ViewBuilder
    func SearchBar() -> some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)

            TextField("Search", text: .constant(""))
                .disabled(true)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 2)
        )
    }

    @ViewBuilder
    func ProductsTabView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(ProductType.allCases, id: \.self) { type in
                    Button {
                        withAnimation {
                            viewModel.productType = type
                        }
                    } label: {
                        Text(type.rawValue)
                            .font(.custom(Raleway.semibold, size: 15))
                            .foregroundColor(
                                viewModel.productType == type
                                ? Color("Purple")
                                : Color.gray
                            )
                            .padding(.bottom, 10)
                        // Adding indicator at bottom
                            .overlay(
                                ZStack {
                                    if viewModel.productType == type {
                                        Capsule()
                                            .fill(Color("Purple"))
                                            .frame(height: 2)
                                            .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                    } else {
                                        Capsule()
                                            .fill(Color.clear)
                                            .frame(height: 2)
                                    }
                                }
                                    .padding(.horizontal, -5 )
                                , alignment: .bottom
                            )
                    }
                }
                .padding(.horizontal, 25)
            }
        }
    }

    @ViewBuilder
    func ProductsPageView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {

            HStack(spacing: 25) {
                ForEach(viewModel.filteredProducts) { product in
                    ProductCardView(with: product)
                }
            }
            .padding(.horizontal, 25)
        }
    }

    @ViewBuilder
    func ProductCardView(with product: Product) -> some View {

        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)

            Text(product.title)
                .foregroundColor(Color.black)
                .font(.custom(Raleway.semibold, size: 18))
                .padding(.top)

            Text(product.subtitle)
                .font(.custom(Raleway.regular, size: 14))
                .foregroundColor(.gray)

            Text(product.price)
                .foregroundColor(Color.black)
                .font (.custom(Raleway.bold, size: 16))
                .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(
            Color.white
                .cornerRadius(25)
                .padding(.top, (getRect().width / 2.5) / 2)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension View {

    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
