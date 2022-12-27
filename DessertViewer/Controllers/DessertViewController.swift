//
//  DessertViewController.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/22/22.
//

import UIKit

class DessertViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
    private var desserts = [Dessert]() {
        didSet {
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
                self.activityIndicatorView.removeFromSuperview()
                self.collectionView.reloadData()
            }
        }
    }
    
    private let dessertViewModel: DessertViewModel
    
    init(dessertViewModel: DessertViewModel) {
        self.dessertViewModel = dessertViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(DessertCollectionViewCell.self,
                                forCellWithReuseIdentifier: DessertCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        dessertViewModel.fetchDesserts(from: Constants.Endpoints.dessertList) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.displayAlert(title: Constants.ErrorAlert.title,
                                      message: Constants.ErrorAlert.dessertListMessage)
                }
            case .success(let desserts):
                // sort desserts alphabetically
                self.desserts = desserts.sorted(by: { $0.strMeal < $1.strMeal })
            }
        }
        
        navigationItem.title = Constants.DessertVC.navigationItemTitle
        view.addSubview(collectionView)
        view.addSubview(activityIndicatorView)
        collectionView.backgroundColor = .systemBackground
        setUpConstraints()
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
        cell.dessertImageView.loadImage(urlString: desserts[indexPath.row].strMealThumb)
        cell.dessertNameLabel.text = desserts[indexPath.row].strMeal
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/Constants.DessertVC.cellWidthRatio - Constants.DessertVC.cellSubConstant,
                      height: view.frame.width/Constants.DessertVC.cellHeightRatio - Constants.DessertVC.cellSubConstant)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: Constants.DessertVC.cellEdgeInsetPadding,
                            left: Constants.DessertVC.cellEdgeInsetPadding,
                            bottom: Constants.DessertVC.cellEdgeInsetPadding,
                            right: Constants.DessertVC.cellEdgeInsetPadding)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let dessertDetailViewModel = DessertDetailViewModel(dessert: desserts[indexPath.row])
        let dessertDetailVC = DessertDetailViewController(dessertDetailViewModel: dessertDetailViewModel)
        navigationController?.pushViewController(dessertDetailVC, animated: true)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

