//
//  DessertDetailViewController.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/25/22.
//

import UIKit

class DessertDetailViewController: UIViewController {

    private let dessertDetailViewModel: DessertDetailViewModel
    
    init(dessertDetailViewModel: DessertDetailViewModel) {
        self.dessertDetailViewModel = dessertDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dessert = dessertDetailViewModel.dessert
        dessertDetailViewModel.fetchDessertDetails(from: "https://themealdb.com/api/json/v1/1/lookup.php?i=" + dessert.idMeal) { result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let dessertDetail):
                print(dessertDetail)
                return
            }
        }
    }

}
