//
//  MenuItem.swift
//  Restaurant
//
//  Created by APPLE on 3/20/25.
//

import Foundation

struct MenuItem: Decodable{
    let title: String
    let image: String
    let price: String
    // Optional extra properties
    let description: String?
}
