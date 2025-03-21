//
//  Onboarding.swift
//  Restaurant
//
//  Created by Subhan on 3/17/25.
//

import SwiftUI

// Global keys for UserDefaults
let kFirstName = "firstNameKey"
let kLastName = "lastNameKey"
let kEmail = "emailKey"
let kIsLoggedIn = "isLoggedInKey" // ✅ New constant to store login state

struct Onboarding: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var isLoggedIn: Bool = false  // Controls navigation

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Create Your Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)

                Text("Please enter your details to register")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                VStack(spacing: 15) {
                    InputField(title: "First Name", text: $firstName)
                    InputField(title: "Last Name", text: $lastName)
                    InputField(title: "Email", text: $email, isEmail: true)
                }
                .padding(.horizontal)

                Button(action: registerUser) {
                    Text("Register")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                Home()  // Navigates to Home when registered
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                    isLoggedIn = true  // ✅ Skip onboarding if already logged in
                }
            }
        }
    }

    func registerUser() {
        if !firstName.isEmpty && !lastName.isEmpty && isValidEmail(email) {
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)  // ✅ Mark as logged in
            
            isLoggedIn = true
        } else {
            print("Please enter valid details")
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}

// Custom Input Field Component
struct InputField: View {
    var title: String
    @Binding var text: String
    var isEmail: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)

            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(isEmail ? .emailAddress : .default)
                .autocapitalization(isEmail ? .none : .words)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}




//#Preview {
//    Onboarding()
//}
