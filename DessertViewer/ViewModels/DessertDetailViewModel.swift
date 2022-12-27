//
//  DessertDetailViewModel.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/25/22.
//

import Foundation

class DessertDetailViewModel {
    
    let dessert: Dessert
    
    init(dessert: Dessert) {
        self.dessert = dessert
    }
    
    func fetchDessertDetails(from endpoint: String, completion: @escaping (Result<DessertDetail, Error>) -> Void) {
        
        guard let url = URL(string: endpoint) else { return }
        
        let request = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode([String:[[String:String?]]].self, from: data!)
                let dessertDetail = result.compactMap { meals -> DessertDetail in
                    let dessertDetailDict = meals.value.first!
                    return DessertDetail(dessertDetailDict: dessertDetailDict)
                }.first!
                completion(.success(dessertDetail))
            } catch {
                completion(.failure(error))
            }
        }
        request.resume()
    }
    
    // returns instructions as a numbered list string
    func formatInstructions(_ instructions: String) -> String {
        // split on \r\n\r\n, \r\n, and between sentences (. )
        let pattern = "\\r\\n\\r\\n|\\r\\n|(?<=\\.) "
        let steps = instructions.split(pattern: pattern).filter { !$0.isEmpty }
        
        var result = ""
        for step in steps.indices {
            result += "\(step + 1). " + steps[step] + "\n"
        }
        
        return result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // returns ingredients/measures as a bullet list string
    func formatIngredientsAndMeasures(_ ingredients: [String], _ measures: [String]) -> String {
        var result = ""
        for i in 0..<min(ingredients.count, measures.count) {
            if ingredients[i].isEmpty || measures[i].isEmpty {
                break
            }
            result += "• \(measures[i]) \(ingredients[i])\n"
        }
        return result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
