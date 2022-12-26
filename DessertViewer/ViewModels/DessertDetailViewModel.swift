//
//  DessertDetailViewModel.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/25/22.
//

import Foundation

class DessertDetailViewModel: ObservableObject {
    
    let dessert: Dessert
    
    init(dessert: Dessert) {
        self.dessert = dessert
    }
    
    func fetchDessertDetails(from endpoint: String, completion: @escaping (Result<DessertDetail, Error>) -> Void) {
        
        let url = URL(string: endpoint)
        
        let request = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                print(error)
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(DessertDetailCollection.self, from: data!)
                completion(.success(result.dessertDetails.first!))
            } catch {
                completion(.failure(error))
            }
        }
        request.resume()
    }
    
    func formatInstructions(_ instructions: String) -> String {
        // split on \r\n\r\n and between sentences (. )
        let pattern = "\\r\\n\\r\\n|(?<=\\.) "
        let steps = instructions.split(pattern: pattern)
        
        var result = ""
        for step in steps.indices {
            result += "\(step + 1). " + steps[step] + "\n"
        }
        
        return result.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}

extension String {
    func split(pattern: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: self, range: NSRange(0..<utf16.count))
        let ranges = [startIndex..<startIndex] + matches.map{Range($0.range, in: self)!} + [endIndex..<endIndex]
        return (0...matches.count).map {String(self[ranges[$0].upperBound..<ranges[$0+1].lowerBound])}
    }
}
