//
//  Dessert.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/23/22.
//

import Foundation

struct DessertCollection: Codable {
    let desserts: [Dessert]
    
    enum CodingKeys: String, CodingKey {
        case desserts = "meals"
    }
}

struct Dessert: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
