//
//  DishDetailView.swift
//  Restaurant
//
//  Created by APPLE on 3/20/25.

import SwiftUI

struct DishDetailView: View {
    let dish: Dish

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: dish.image!)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 200)

            Text(dish.title!)
                .font(.title)
                .bold()

            Text("$\(dish.price!)")
                .font(.title2)
                .foregroundColor(.green)

            Spacer()
        }
        .padding()
    }
}


//#Preview {
//    DishDetailView(dish: <#T##Dish#>)
//}
