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
    
}
