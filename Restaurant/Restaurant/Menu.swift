//
//  Menu.swift
//  Restaurant
//
//  Created by APPLE on 3/17/25.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(spacing: 10) {
            // Application Title
            Text("Little Lemon")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 40)

            // Restaurant Location
            Text("Chicago, IL")
                .font(.title2)
                .foregroundColor(.gray)

            // Short Description
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)

            // Empty List for Menu Items (to be populated later)
            List {
                // Menu items will be added here later
            }
        }
        .padding()
    }
}

#Preview {
    Menu()
}
