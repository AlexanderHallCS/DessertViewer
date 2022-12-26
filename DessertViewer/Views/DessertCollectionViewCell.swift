//
//  DessertCollectionViewCell.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/22/22.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DessertCollectionViewCell"
    
    let dessertImageView: DessertImageView = {
        let imageView = DessertImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dessertImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dessertImageView.frame = contentView.bounds
    }
    
}
