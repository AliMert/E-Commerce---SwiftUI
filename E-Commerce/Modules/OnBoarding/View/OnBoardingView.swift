//
//  OnBoardingView.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 28.05.2022.
//

import SwiftUI

struct OnBoardingView: View {

    @State private var showLogin: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Spacer()

            Text("Find your\nGadgets!")
                .font(.custom(Raleway.bold, size: 55))
                .foregroundColor(.white)
                .padding(.horizontal)

            Image("OnBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .fade()

            Spacer()

            Button {
                withAnimation {
                    self.showLogin.toggle()
                }
            } label: {
                Text("Get Started")
                    .font(.custom(Raleway.semibold, size: 18))
                    .padding(.vertical, 18)
                    .maxWidth(350)
                    .background(Color.white)
                    .foregroundColor(Color("Purple"))
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
        }
        .padding(.vertical, 10)
        .maxWidthAndHeight()
        .background(Color("Purple"))
        .overlay {
            Group {
                if showLogin {
                    LoginView()
                        .transition(.move(edge: .bottom))
                }
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
