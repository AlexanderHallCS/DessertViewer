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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    let instructionsLabel: UILabel = {
        let instructionsLabel = UILabel()
        instructionsLabel.text = "Instructions:"
        instructionsLabel.minimumScaleFactor = 0.5
        instructionsLabel.font = .systemFont(ofSize: 30)
        return instructionsLabel
    }()
    
    let instructionsListLabel: UILabel = {
        let instructionsListLabel = UILabel()
        instructionsListLabel.minimumScaleFactor = 0.5
        instructionsListLabel.font = .systemFont(ofSize: 14)
        instructionsListLabel.numberOfLines = 0
        return instructionsListLabel
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
                return
            case .success(let dessertDetail):
                print(dessertDetail)
                let instructions = dessertDetail.strInstructions ?? ""
                DispatchQueue.main.async {
                    self.instructionsListLabel.text = self.dessertDetailViewModel.formatInstructions(instructions)
                }
                return
            }
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        dessertImageParentView.addSubview(dessertImageView)
        stackView.addArrangedSubview(dessertImageParentView)
        stackView.addArrangedSubview(instructionsLabel)
        stackView.addArrangedSubview(instructionsListLabel)
        
        dessertImageView.loadImage(urlString: dessert.strMealThumb)
        
        setUpConstraints()
        
        view.backgroundColor = .systemBackground
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            dessertImageParentView.heightAnchor.constraint(equalToConstant: view.frame.height/3),
            dessertImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dessertImageView.centerYAnchor.constraint(equalTo: dessertImageParentView.centerYAnchor),
            dessertImageView.widthAnchor.constraint(equalToConstant: view.frame.width/1.5),
            dessertImageView.heightAnchor.constraint(equalToConstant: view.frame.width/1.5),
            
            instructionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }
    
}
