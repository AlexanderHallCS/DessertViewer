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
        instructionsLabel.text = Constants.DessertDetailVC.instructionsLabelText
        instructionsLabel.minimumScaleFactor = Constants.DessertDetailVC.minimumScaleFactor
        instructionsLabel.adjustsFontSizeToFitWidth = true
        instructionsLabel.font = .systemFont(ofSize: Constants.DessertDetailVC.sectionLabelFont)
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionsLabel
    }()
    
    let instructionsListLabel: UILabel = {
        let instructionsListLabel = UILabel()
        instructionsListLabel.minimumScaleFactor = Constants.DessertDetailVC.minimumScaleFactor
        instructionsListLabel.adjustsFontSizeToFitWidth = true
        instructionsListLabel.font = .systemFont(ofSize: Constants.DessertDetailVC.listLabelFont)
        instructionsListLabel.numberOfLines = 0
        instructionsListLabel.translatesAutoresizingMaskIntoConstraints = false
        return instructionsListLabel
    }()
    
    let ingredientsLabel: UILabel = {
        let ingredientsLabel = UILabel()
        ingredientsLabel.text = Constants.DessertDetailVC.ingredientsLabelText
        ingredientsLabel.minimumScaleFactor = Constants.DessertDetailVC.minimumScaleFactor
        ingredientsLabel.adjustsFontSizeToFitWidth = true
        ingredientsLabel.font = .systemFont(ofSize: Constants.DessertDetailVC.sectionLabelFont)
        ingredientsLabel.translatesAutoresizingMaskIntoConstraints = false
        return ingredientsLabel
    }()
    
    let ingredientsListLabel: UILabel = {
        let ingredientsListLabel = UILabel()
        ingredientsListLabel.minimumScaleFactor = Constants.DessertDetailVC.minimumScaleFactor
        ingredientsListLabel.adjustsFontSizeToFitWidth = true
        ingredientsListLabel.font = .systemFont(ofSize: Constants.DessertDetailVC.listLabelFont)
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
        
        dessertDetailViewModel.fetchDessertDetails(from: Constants.Endpoints.dessert + dessert.idMeal) { result in
            switch result {
            case .failure(_):
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.removeFromSuperview()
                    self.displayAlert(title: Constants.ErrorAlert.title,
                                      message: Constants.ErrorAlert.dessertMessage)
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
            dessertImageView.widthAnchor.constraint(equalToConstant: view.frame.height/Constants.DessertDetailVC.Constraints.imageViewDimRatio),
            dessertImageView.heightAnchor.constraint(equalToConstant: view.frame.height/Constants.DessertDetailVC.Constraints.imageViewDimRatio),
            
            instructionsLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            instructionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            instructionsLabel.bottomAnchor.constraint(equalTo: instructionsListLabel.topAnchor, constant: -Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            
            instructionsListLabel.topAnchor.constraint(equalTo: instructionsLabel.bottomAnchor, constant: Constants.DessertDetailVC.Constraints.listLabelVertPadding),
            instructionsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.DessertDetailVC.Constraints.listLabelHorizPadding),
            instructionsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.DessertDetailVC.Constraints.listLabelHorizPadding),
            instructionsListLabel.bottomAnchor.constraint(equalTo: ingredientsLabel.topAnchor, constant: -Constants.DessertDetailVC.Constraints.listLabelVertPadding),
            
            ingredientsLabel.topAnchor.constraint(equalTo: instructionsListLabel.bottomAnchor, constant: Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            ingredientsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            ingredientsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            ingredientsLabel.bottomAnchor.constraint(equalTo: ingredientsListLabel.topAnchor, constant: -Constants.DessertDetailVC.Constraints.sectionLabelPadding),
            
            ingredientsListLabel.topAnchor.constraint(equalTo: ingredientsLabel.bottomAnchor, constant: Constants.DessertDetailVC.Constraints.listLabelVertPadding),
            ingredientsListLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.DessertDetailVC.Constraints.listLabelHorizPadding),
            ingredientsListLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.DessertDetailVC.Constraints.listLabelHorizPadding),
            ingredientsListLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            activityIndicatorView.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor, constant: Constants.DessertDetailVC.Constraints.activityIndicatorTopPadding),
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
