//
//  DessertDetail.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/24/22.
//

import Foundation

struct DessertDetailCollection: Codable {
    let dessertDetails: [DessertDetail]
    
    enum CodingKeys: String, CodingKey {
        case dessertDetails = "meals"
    }
}

struct DessertDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let ingredients: [String]
    let measures: [String]
    let strSource: String?
    let strImageSource: String?
    let strCreativeCommonsConfirmed: String?
    let dateModified: String?
    
    init(dessertDetailDict: [String:String?]) {
        
        var ingredients = Array.init(repeating: "", count: 20)
        var measures = Array.init(repeating: "", count: 20)
        
        // find all keys starting with "strIngredient" or "strMeasure" and add their value
        // to the ingredients and measures lists
        for (key, val) in dessertDetailDict {
            if key.starts(with: "strIngredient") {
                let ingredient = val?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                // extract index(#) from, "strIngredient#"
                let ingredientIdx = Int(key.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())! - 1
                ingredients[ingredientIdx] = ingredient ?? ""
            }
            if key.starts(with: "strMeasure") {
                let measure = val?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                // extract index(#) from, "strMeasure#"
                let measureIdx = Int(key.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())! - 1
                measures[measureIdx] = measure ?? ""
            }
        }
        
        self.idMeal = dessertDetailDict["idMeal"]! ?? ""
        self.strMeal = dessertDetailDict["strMeal"]! ?? ""
        self.strDrinkAlternate = dessertDetailDict["strDrinkAlternate"]!
        self.strCategory = dessertDetailDict["strCategory"]! ?? ""
        self.strInstructions = dessertDetailDict["strInstructions"]!
        self.strMealThumb = dessertDetailDict["strMealThumb"]!
        self.strTags = dessertDetailDict["strTags"]!
        self.strYoutube = dessertDetailDict["strYoutube"]!
        self.ingredients = ingredients
        self.measures = measures
        self.strSource = dessertDetailDict["strSource"]!
        self.strImageSource = dessertDetailDict["strImageSource"]!
        self.strCreativeCommonsConfirmed = dessertDetailDict["strCreativeCommonsConfirmed"]!
        self.dateModified = dessertDetailDict["dateModified"]!
    }
}
