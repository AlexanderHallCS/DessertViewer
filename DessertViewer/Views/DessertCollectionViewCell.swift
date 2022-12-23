//
//  DessertCollectionViewCell.swift
//  DessertViewer
//
//  Created by Alexander Hall on 12/22/22.
//

import UIKit

class DessertCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DessertCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // TODO: Replace below with fetched image
        //imageView.image = UIImage()
        imageView.backgroundColor = .red
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
}