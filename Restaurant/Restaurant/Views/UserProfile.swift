//
//  UserProfile.swift
//  Restaurant
//
//  Created by APPLE on 3/17/25.
//

import SwiftUI

struct UserProfile: View {
    // Load user data from UserDefaults
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? "Unknown"
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? "User"
    let email = UserDefaults.standard.string(forKey: kEmail) ?? "No Email"

    @Environment(\.presentationMode) var presentation  // Needed for logout

    var body: some View {
        VStack(spacing: 20) {
            Text("Personal Information")
                .font(.largeTitle)
                .fontWeight(.bold)

            Image("profile-image-placeholder") // ✅ Ensure this exists in Assets
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 10) {
                Text("First Name: \(firstName)")
                Text("Last Name: \(lastName)")
                Text("Email: \(email)")
            }
            .font(.headline)
            .padding(.horizontal)

            Button(action: logout) {
                Text("Logout")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    func logout() {
        UserDefaults.standard.set(false, forKey: kIsLoggedIn) // ✅ Mark as logged out
        self.presentation.wrappedValue.dismiss()  // ✅ Navigate back to Onboarding
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}


#Preview {
    UserProfile()
}
