//
//  DessertDetailViewController.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/25/22.
//

import UIKit

class DessertDetailViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    let dessertImageView: DessertImageView = {
        let imageView = DessertImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.text = "Instructions:"
        instructionsLabel.minimumScaleFactor = 0.5
        instructionsLabel.font = .systemFont(ofSize: 20)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionsLabel
    }()
    
    let instructionsListLabel: UILabel = {
        let instructionsListLabel = UILabel()
        instructionsListLabel.minimumScaleFactor = 0.5
        instructionsListLabel.font = .systemFont(ofSize: 14)
        instructionsListLabel.numberOfLines = 0
        instructionsListLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionsListLabel
    }()
    
    let ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = "Ingredients/Measurements:"
        ingredientsLabel.minimumScaleFactor = 0.5
        ingredientsLabel.font = .systemFont(ofSize: 20)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    let ingredientsListLabel: UILabel = {
        let ingredientsListLabel = UILabel()
        ingredientsListLabel.minimumScaleFactor = 0.5
        ingredientsListLabel.font = .systemFont(ofSize: 14)
        ingredientsListLabel.numberOfLines = 0
        ingredientsListLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsListLabel
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.startAnimating()
        activityIndicatorView.style = .large
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()
    
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
        navigationItem.title = dessert.strMeal
        
        dessertDetailViewModel.fetchDessertDetails(from: "https://themealdb.com/api/json/v1/1/lookup.php?i=" + dessert.idMeal) { result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.removeFromSuperview()
                    self.displayAlert(title: "Error!", message: "Could not get dessert details! Please go back and try again.")
                }
                return
            case .success(let dessertDetail):
                let instructions = dessertDetail.strInstructions ?? ""
                DispatchQueue.main.async {
                    self.instructionsListLabel.text = self.dessertDetailViewModel.formatInstructions(instructions)
                    self.ingredientsListLabel.text = self.dessertDetailViewModel.formatIngredientsAndMeasures(dessertDetail.ingredients, dessertDetail.measures)
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.removeFromSuperview()
                }
                return
            }
        }
        
        view.addSubview(scrollView)
        view.addSubview(activityIndicatorView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(dessertImageView)
        contentView.addSubview(instructionsLabel)
        contentView.addSubview(instructionsListLabel)
        contentView.addSubview(ingredientsLabel)
        contentView.addSubview(ingredientsListLabel)
        
        dessertImageView.loadImage(urlString: dessert.strMealThumb)
        setUpConstraints()
        
        view.backgroundColor = .systemBackground
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            dessertImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            dessertImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dessertImageView.widthAnchor.constraint(equalToConstant: view.frame.width/1.5),
            dessertImageView.heightAnchor.constraint(equalToConstant: view.frame.width/1.5),
            
            instructionsLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 10),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            instructionsLabel.bottomAnchor.constraint(equalTo: instructionsListLabel.topAnchor, constant: -10),
            
            instructionsListLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: 10),
            instructionsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            instructionsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            instructionsListLabel.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor, constant: -10),
            
            ingredientsLabel.topAnchor.constraint(equalTo: instructionsListLabel.bottomAnchor, constant: 10),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ingredientsLabel.bottomAnchor.constraint(equalTo: ingredientsListLabel.topAnchor, constant: -10),
            
            ingredientsListLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: 10),
            ingredientsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ingredientsListLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicatorView.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 10),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
