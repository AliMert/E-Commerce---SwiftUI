//
//  LoginView.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 28.05.2022.
//

import SwiftUI

struct LoginView: View {

    @StateObject private var viewModel: LoginViewModel = .init()

    var body: some View {

        ZStack {
            Color("Purple")

            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    VStack {

                        // Welcome Back text for 3 half of the screen...
                        Text(viewModel.registerUser ? "Welcome" : "Welcome\nback")
                            .font(.custom(Raleway.bold, size: 50))
                            .foregroundColor(.white)
                            .maxWidth(alignment: viewModel.registerUser ? .center : .leading)
                            .frame(height: UIScreen.main.bounds.height / 3.5)
                            .padding()
                            .background {
                                // Gradient Circle...
                                Circle()
                                    .foregroundColor(Color("LoginCircle"))
                                    .fade(gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0),
                                        .init(color: .black.opacity(0.3), location: 0.15),
                                        .init(color: .black.opacity(0.5), location: 0.25),
                                        .init(color: .black.opacity(0.7), location: 0.5),
                                        .init(color: .black.opacity(0.8), location: 0.75)
                                    ]))
                                    .frame(width: 110, height: 110)
                                    .maxWidthAndHeight(alignment: .topTrailing)
                                    .offset(y: -45)
                                    .ignoresSafeArea()
                                    .padding(.trailing)

                                Circle()
                                    .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                                    .frame(width: 30, height: 30)
                                    .blur(radius: 2)
                                    .maxWidthAndHeight(alignment: .bottomTrailing)
                                    .padding(30)

                                Circle()
                                    .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                                    .frame(width: 23, height: 23)
                                    .blur(radius: 2)
                                    .maxWidthAndHeight(alignment: .topLeading)
                                    .padding(.leading, 30)
                            }

                        // Login Page Form....
                        VStack(spacing: 30) {
                            Text(viewModel.registerUser ? "Register" : "Login")
                                .font(.custom(Raleway.bold, size: 22))
                                .padding(.top, 15)
                                .maxWidth(alignment: .leading)

                            // Custom Text Field...

                            CustomTextField(
                                icon: "envelope",
                                title: "Email",
                                hint: "Email...",
                                value: $viewModel.email
                            )

                            CustomTextField(
                                icon: "lock",
                                title: "Password",
                                hint: "Password...",
                                value: $viewModel.password,
                                showPassword: $viewModel.showPassword
                            )

                            // If user is registering show re-enter password
                            // else show forgot password button
                            if viewModel.registerUser {
                                CustomTextField(
                                    icon: "lock",
                                    title: "Re-Enter Password",
                                    hint: "Enter the same Password...",
                                    value: $viewModel.reEnterPassword,
                                    showPassword: $viewModel.showReEnterPassword
                                )
//                                .ignoresSafeArea(.keyboard, edges: .bottom)
                            } else {
                                Button {
                                    viewModel.forgotPassword()
                                } label: {
                                    Text("Forgot Password?")
                                        .font(.custom(Raleway.semibold, size: 14))
                                        .foregroundColor(Color("Purple"))
                                        .maxWidth(alignment: .leading)
                                }
                            }

                            // Register/Login Button
                            Button {
                                if viewModel.registerUser {
                                    viewModel.register()
                                } else {
                                    viewModel.login()
                                }
                            } label: {
                                Text(viewModel.registerUser ? "Register" : "Login")
                                    .font(.custom(Raleway.bold, size: 17))
                            }
                            .fullScreenCover(isPresented: $viewModel.goToDashboardView) {
                                DashboardView()
                            }
                            .padding(20)
                            .maxWidth(300)
                            .background(Color("Purple"))
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .black.opacity(0.2), radius: 5, x: 5, y: 5)
                            .padding(.top, 10)

                            Button {
                                withAnimation {
                                    viewModel.registerUser.toggle()
                                }
                            } label: {
                                Text(viewModel.registerUser ? "Do you have an Account?" : "Create an Account")
                                    .font(.custom(Raleway.semibold, size: 14))
                                    .foregroundColor(Color("Purple"))
                            }

                        }
                        .maxHeight(alignment: .top)
                        .padding([.horizontal])
                        .padding(.vertical, 10)
                        .background {
                            Color(.systemBackground)
                                .cornerRadius(20)
                        }
                        
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
        .ignoresSafeArea(.container, edges: [.top, .bottom])
        .onChange(of: viewModel.registerUser) { _ in
            viewModel.clearData()
        }
    }

    @ViewBuilder
    func CustomTextField(
        icon: String,
        title: String,
        hint: String,
        value: Binding<String>,
        showPassword: Binding<Bool>? = nil
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Label {
                Text(title)
                    .font(.custom(Raleway.regular, size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color(.label).opacity(0.8))

            if  showPassword?.wrappedValue == false {
                SecureField(hint, text: value)
                    .textContentType(.password)
                    .padding(.top, 2)
            }
            else{
                TextField(hint, text: value)
                    .padding(.top, 2)
            }

            Divider()
                .background(Color.black.opacity(0.4))
        }
        // Showing Show Button for password Field...
        .overlay(alignment: .trailing) {

            Group {

                if showPassword != nil {
                    Button(action: {
                        showPassword?.wrappedValue.toggle()
                    }, label: {
                        Text(showPassword?.wrappedValue == true ? "Hide" : "Show")
                            .font(.custom(Raleway.bold, size: 13))
                            .foregroundColor(Color("Purple"))
                    })
                    .offset(y: 8)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
