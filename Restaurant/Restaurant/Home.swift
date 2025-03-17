//
//  Home.swift
//  Restaurant
//
//  Created by APPLE on 3/17/25.
//

import SwiftUI


struct Home: View {
    var body: some View {
        NavigationStack {
            TabView {
                Menu()  // Existing Menu tab
                    .tabItem {
                        Label("Menu", systemImage: "list.dash")
                    }
                
                UserProfile()  // ✅ New Profile tab
                    .tabItem {
                        Label("Profile", systemImage: "square.and.pencil")
                    }
            }
            .navigationBarBackButtonHidden(true) // Hide back button
        }
    }
}


#Preview {
    Home()
}
