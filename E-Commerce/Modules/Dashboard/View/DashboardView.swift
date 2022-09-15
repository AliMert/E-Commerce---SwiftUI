//
//  DashboardView.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 13.09.2022.
//

import SwiftUI

struct DashboardView: View {

    @State var currentTab: Tab = .home

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        VStack {
            TabView(selection: $currentTab) {
                HomeView()
                    .tag(Tab.home)

                Text(currentTab.rawValue)
                    .tag(Tab.liked)

                Text(currentTab.rawValue)
                    .tag(Tab.profile)

                Text(currentTab.rawValue)
                    .tag(Tab.cart)
            }

            // Custom Tab Bar
            HStack(spacing: .zero) {
                ForEach(Tab.allCases, id: \.self) { tab in

                    Button {
                        // updating tab
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                // applying shadow
                                Color("Purple")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                    .blur(radius: 5)
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .maxWidth()
                            .foregroundColor(
                                currentTab == tab
                                ? Color("Purple")
                                : Color.black.opacity(0.3)
                            )
                    }
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
