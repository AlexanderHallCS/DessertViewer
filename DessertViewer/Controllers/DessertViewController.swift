//
//  DessertViewController.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/22/22.
//

import UIKit

class DessertViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private let dessertViewModel: DessertViewModel
    
    init(dessertViewModel: DessertViewModel) {
        self.dessertViewModel = dessertViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var desserts = [Dessert]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(DessertCollectionViewCell.self,
                                forCellWithReuseIdentifier: DessertCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = "Desserts"
        view.addSubview(collectionView)
        
        dessertViewModel.fetchDesserts(from: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let desserts):
                // sort desserts alphabetically
                self.desserts = desserts.sorted(by: { $0.strMeal < $1.strMeal })
                //print(self.desserts)
            case .failure(let error):
                print("Error occured with message \(error)")
                // TODO: Present error alert view
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return desserts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: DessertCollectionViewCell.identifier, for: indexPath) as? DessertCollectionViewCell)!
        // TODO: Remove this if statement and replace with property observation/waiting for first callback to finish, etc.
        if !desserts.isEmpty {
            // TODO: Fix this so it doesn't directly access the struct property
            cell.imageView.loadImage(urlString: desserts[indexPath.row].strMealThumb)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 10,
                      height: view.frame.width/2 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let dessertDetailViewModel = DessertDetailViewModel(dessert: desserts[indexPath.row])
        let dessertDetailVC = DessertDetailViewController(dessertDetailViewModel: dessertDetailViewModel)
        navigationController?.pushViewController(dessertDetailVC, animated: true)
        //print(desserts[indexPath.row])
    }
    
}

