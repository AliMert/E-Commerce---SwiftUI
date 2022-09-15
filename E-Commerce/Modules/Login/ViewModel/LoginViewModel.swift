//
//  LoginViewModel.swift
//  E-Commerce
//
//  Created by Ali Mert Özhayta on 28.05.2022.
//

import Foundation

class LoginViewModel: ObservableObject {

    // Login Properties..
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false

    // Register Properties
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false

    // Navigation Properties
    @Published var goToDashboardView: Bool = false

    // Login Call...
    func login() {
        goToDashboardView = true
    }

    func register() {
        // Do Action Here...
    }

    func forgotPassword() {
        // Do Action Here...
    }

    func clearData() {
        email = ""
        password = ""
        showPassword = false
        reEnterPassword = ""
        showReEnterPassword = false
    }
}
