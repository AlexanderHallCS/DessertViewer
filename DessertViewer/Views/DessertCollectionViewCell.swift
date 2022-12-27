//
//  DessertCollectionViewCell.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/22/22.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DessertCollectionViewCell"
    
    let dessertView = UIView()
    
    let dessertImageView: DessertImageView = {
        let imageView = DessertImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dessertNameLabel: UILabel = {
        let dessertNameLabel = UILabel()
        dessertNameLabel.minimumScaleFactor = 0.5
        dessertNameLabel.adjustsFontSizeToFitWidth = true
        dessertNameLabel.font = .systemFont(ofSize: 30)
        dessertNameLabel.textAlignment = .center
        dessertNameLabel.numberOfLines = 0
        dessertNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return dessertNameLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dessertView)
        dessertView.addSubview(dessertImageView)
        dessertView.addSubview(dessertNameLabel)
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            dessertImageView.topAnchor.constraint(equalTo: dessertView.topAnchor),
            dessertImageView.leadingAnchor.constraint(equalTo: dessertView.leadingAnchor),
            dessertImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            dessertImageView.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            dessertNameLabel.topAnchor.constraint(equalTo: dessertImageView.bottomAnchor),
            dessertNameLabel.centerXAnchor.constraint(equalTo: dessertImageView.centerXAnchor),
            dessertNameLabel.widthAnchor.constraint(equalTo: dessertImageView.widthAnchor),
            dessertNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dessertImageView.frame = contentView.bounds
    }
    
}
