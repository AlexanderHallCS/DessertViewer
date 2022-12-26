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
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let dessertImageParentView = UIView()
    
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
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.removeFromSuperview()
                }
                return
            case .success(let dessertDetail):
                print(dessertDetail)
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
        scrollView.addSubview(stackView)
        
        dessertImageParentView.addSubview(dessertImageView)
        stackView.addArrangedSubview(dessertImageParentView)
        
        stackView.addArrangedSubview(instructionsLabel)
        stackView.addArrangedSubview(instructionsListLabel)
        
        stackView.addArrangedSubview(ingredientsLabel)
        stackView.addArrangedSubview(ingredientsListLabel)
        
        dessertImageView.loadImage(urlString: dessert.strMealThumb)
        scrollView.showsVerticalScrollIndicator = false
        
        setUpConstraints()
        
        view.backgroundColor = .systemBackground
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            dessertImageParentView.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            dessertImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dessertImageView.centerYAnchor.constraint(equalTo: dessertImageParentView.centerYAnchor),
            dessertImageView.widthAnchor.constraint(equalToConstant: view.frame.width/1.5),
            dessertImageView.heightAnchor.constraint(equalToConstant: view.frame.width/1.5),
            
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            instructionsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ingredientsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            activityIndicatorView.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: 10),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
