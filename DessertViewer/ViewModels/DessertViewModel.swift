//
//  DessertViewModel.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/24/22.
//

import Foundation

class DessertViewModel {
    
    func fetchDesserts(from endpoint: String, completion: @escaping (Result<[Dessert], Error>) -> Void) {
        
        let url = URL(string: endpoint)
        
        let request = URLSession.shared.dataTask(with: url!) { data, response, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(DessertCollection.self, from: data!)
                completion(.success(result.desserts))
            } catch {
                completion(.failure(error))
            }
        }
        request.resume()
    }
    
}
